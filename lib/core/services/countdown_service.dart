import 'dart:async';

enum TaskStatus { idle, running, paused, finished }

class TaskState {
  final int secondsLeft;
  final TaskStatus status;
  final int initialSeconds;

  TaskState({
    required this.secondsLeft,
    required this.status,
    required this.initialSeconds,
  });

  double get progress => initialSeconds == 0 ? 0 : secondsLeft / initialSeconds;
  bool get isRunning => status == TaskStatus.running;
  bool get isFinished => status == TaskStatus.finished;
}

class CountdownService {
  StreamController<TaskState> controller = StreamController.broadcast();
  Stream<TaskState> get stream => controller.stream;
  int initialCount = 15;
  late TaskState lastState;
  Timer? timer;
  bool _closed = false;

  CountdownService() {
    lastState = TaskState(
      secondsLeft: initialCount,
      status: TaskStatus.idle,
      initialSeconds: initialCount,
    );
    controller.add(lastState);
  }

  start() {
    if (lastState.isRunning) {
      return;
    }
    int startfrom = lastState.isFinished
        ? lastState.initialSeconds
        : lastState.secondsLeft;

    _update(
      TaskState(
        secondsLeft: startfrom,
        status: TaskStatus.running,
        initialSeconds: lastState.initialSeconds,
      ),
    );
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var newSecond = lastState.secondsLeft - 1;
      if (newSecond <= 0) {
        _update(
          TaskState(
            secondsLeft: 0,
            status: TaskStatus.finished,
            initialSeconds: lastState.initialSeconds,
          ),
        );
        timer.cancel();
      } else {
        _update(
          TaskState(
            secondsLeft: newSecond,
            status: TaskStatus.running,
            initialSeconds: lastState.initialSeconds,
          ),
        );
      }
    });
  }

  _update(TaskState newstate) {
    lastState = newstate;
    if (!_closed) {
      controller.add(lastState);
    }
  }

  pause() {
    if (!lastState.isRunning) {
      return;
    }
    timer?.cancel();
    _update(
      TaskState(
        secondsLeft: lastState.secondsLeft,
        status: TaskStatus.paused,
        initialSeconds: lastState.initialSeconds,
      ),
    );
  }

  resume() {
    if (lastState.status != TaskStatus.paused) {
      start();
    }
  }

  dispose() {
    _closed = true;
    timer?.cancel();
    controller.close();
  }

  isDone() {
    return lastState.isFinished;
  }
}
