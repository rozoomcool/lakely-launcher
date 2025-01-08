import 'package:lakely/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  /// Создаёт экземпляр ObjectBox для использования в приложении.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "db"));
    return ObjectBox._create(store);
  }
}
