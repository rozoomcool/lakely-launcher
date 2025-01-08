import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

@Entity()
class App {
  @Id()
  int id = 0;

  String title;
  String packageName;
  Uint8List? icon;

  App({required this.title, required this.packageName, this.icon});
}