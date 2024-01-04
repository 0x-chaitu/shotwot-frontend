import 'package:flutter/material.dart';
import 'package:shotwot_frontend/injection.dart';

import 'package:shotwot_frontend/src/app.dart';
import 'package:shotwot_frontend/src/utils/objectbox.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  await configureDependencies();
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: App(),
      ),
    ),
  ));
}
