import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  @Id()
  int id = 0;

  @Index()
  String title;

  String content;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  Note({
    required this.title,
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
