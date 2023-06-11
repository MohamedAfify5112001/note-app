import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'model/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  const secureStorage = FlutterSecureStorage();
  final encryptionKey = await secureStorage.read(key: 'key');
  if (encryptionKey == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'key');
  final $encryptionKey = base64Url.decode(key!);
  await Hive.openBox<Note>('notes',
      encryptionCipher: HiveAesCipher($encryptionKey));
  runApp(MyApp());
}
