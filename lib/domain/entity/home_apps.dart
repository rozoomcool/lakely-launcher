import 'package:lakely/domain/entity/apps.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class HomeApp {
  @Id()
  int id = 0;

  @Unique()
  final ToOne<App> app = ToOne<App>();

  int position;

  HomeApp({required this.position});
}
