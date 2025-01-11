import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lakely/domain/db/objectbox.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/domain/service/notes_service.dart';

// Состояния для управления заметками
abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesState {
  const NotesInitial();
}

class NotesLoading extends NotesState {
  const NotesLoading();
}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  const NotesLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit для управления заметками
class NotesCubit extends Cubit<NotesState> {
  final NotesService _notesService;

  NotesCubit(this._notesService) : super(const NotesInitial());

  Future<void> init() async {
    fetchNotes();
  }

  /// Получить все заметки
  Future<void> fetchNotes() async {
    emit(const NotesLoading());
    try {
      final notes = _notesService.getAllNotes();
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  /// Добавить новую заметку
  Future<void> addNote(String title, String content) async {
    emit(const NotesLoading());
    try {
      _notesService.addNote(title, content);
      await fetchNotes(); // Обновляем список заметок
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  /// Обновить существующую заметку
  Future<void> updateNote(int id, {String? title, String? content}) async {
    emit(const NotesLoading());
    try {
      final success =
          _notesService.updateNote(id, title: title, content: content);
      if (success) {
        await fetchNotes(); // Обновляем список заметок
      } else {
        emit(const NotesError('Не удалось обновить заметку'));
      }
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  /// Удалить заметку
  Future<void> deleteNoteById(int id) async {
    try {
      _notesService.deleteNoteById(id);
      await fetchNotes(); // Обновляем список заметок
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  /// Поиск заметок по заголовку
  Future<void> searchNotes(String keyword) async {
    emit(const NotesLoading());
    try {
      final notes = _notesService.searchNotesByTitle(keyword);
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
