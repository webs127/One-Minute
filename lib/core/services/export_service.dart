import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:oneminute/models/journal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  ExportService._();

  static final ExportService instance = ExportService._();

  String buildExportText(List<Journal> journals) {
    final sorted = List<Journal>.from(journals)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.map((j) => '${j.date}\n\n${j.content}').join('\n\n---\n\n');
  }

  Future<void> export(List<Journal> journals, BuildContext context) async {
    final text = buildExportText(journals);
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/one_minute_entries.txt');
    await file.writeAsString(text, flush: true);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'text/plain')],
        fileNameOverrides: ['one_minute_entries.txt'],
        subject: 'One Minute Entries',
        sharePositionOrigin: origin,
      ),
    );
  }
}
