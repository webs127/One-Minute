import 'package:hive_ce/hive_ce.dart';
import 'package:oneminute/models/journal.dart';
part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Journal>(),
])

void _() {}