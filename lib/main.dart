import 'package:flutter/material.dart';
import 'package:oneminute/app/app.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:oneminute/hive/hive_registrar.g.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  
  runApp(const MyApp());
}

