import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/objectbox.g.dart';

class NotesService {
  final Store _store;

  NotesService(this._store);

  /// Получить все заметки
  List<Note> getAllNotes() {
    final noteBox = _store.box<Note>();
    return noteBox.getAll();
  }

  /// Получить заметку по ID
  Note? getNoteById(int id) {
    final noteBox = _store.box<Note>();
    return noteBox.get(id);
  }

  /// Добавить новую заметку
  int addNote(String title, String content) {
    final noteBox = _store.box<Note>();
    final note = Note(title: title, content: content);
    return noteBox.put(note);
  }

  /// Обновить заметку (централизованное обновление `updatedAt`)
  bool updateNote(int id, {String? title, String? content}) {
    final noteBox = _store.box<Note>();
    final note = noteBox.get(id);

    if (note != null) {
      if (title != null) note.title = title;
      if (content != null) note.content = content;
      note.updatedAt = DateTime.now(); // Обновляем `updatedAt`
      noteBox.put(note);
      return true;
    }

    return false;
  }

  /// Удалить заметку по ID
  bool deleteNoteById(int id) {
    final noteBox = _store.box<Note>();
    return noteBox.remove(id);
  }

  /// Найти заметки по заголовку
  List<Note> searchNotesByTitle(String keyword) {
    final noteBox = _store.box<Note>();
    final query = noteBox.query(Note_.title.contains(keyword)).build();
    final results = query.find();
    query.close(); // Закрываем запрос для освобождения ресурсов
    return results;
  }
}
