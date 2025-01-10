import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/domain/service/notes_service.dart';

part 'note_state.dart';

part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesService _notesService;

  NoteBloc(this._notesService) : super(NoteInitial()) {
    on<LoadNote>(_onLoadNote);
    // on<InitializeNewNote>(_onInitializeNewNote);
    on<UpdateNote>(_onUpdateNote);
    // on<UpdateNoteContent>(_onUpdateNoteContent);
    // on<AutoSaveNote>(_onAutoSaveNote);
    on<SaveNote>(_onSaveNote);
  }

  Future<void> _onLoadNote(LoadNote event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      if (event.noteId == null) {
        emit(NoteEmpty());
        return;
      }
      final note = _notesService.getNoteById(event.noteId!);
      if (note == null) {
        emit(NoteError("Заметка не найдена"));
        return;
      }
      emit(NoteLoaded(note));
    } catch (e) {
      emit(NoteError('Не удалось загрузить заметку.'));
    }
  }

  void _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) {
    if (state is NoteEmpty) {
      final noteId =
          _notesService.addNote(event.title ?? "", event.content ?? "");
      final note = _notesService.getNoteById(noteId)!;
      emit(NoteLoaded(note));
    }
    if (state is NoteModified) {
      final currentState = state as NoteModified;
      final updatedNote = currentState.note
        ..title = event.title ?? currentState.note.title
        ..content = event.content ?? currentState.note.content;
      emit(NoteModified(updatedNote));
    }
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;
      final updatedNote = currentState.note
        ..title = event.title ?? currentState.note.title
        ..content = event.content ?? currentState.note.content;
      emit(NoteModified(updatedNote));
    }
  }

  Future<void> _onSaveNote(SaveNote event, Emitter<NoteState> emit) async {
    if (state is NoteModified) {
      final currentState = state as NoteModified;
      final isUpdated = _notesService.updateNote(currentState.note.id,
          title: currentState.note.title, content: currentState.note.content);
      if (isUpdated){
        final note = _notesService.getNoteById(currentState.note.id)!;
        emit(NoteLoaded(note));
      }
    }
  }

// void _onUpdateNoteTitle(UpdateNoteTitle event, Emitter<NoteState> emit) {
//   if (state is NoteEmpty) {
//     final noteId = _notesService.addNote(event.title, "");
//     final note = _notesService.getNoteById(noteId)!;
//     emit(NoteLoaded(note));
//   }
//   if (state is NoteModified) {
//     final currentState = state as NoteLoaded;
//     final updatedNote = currentState.note..title = event.title;
//     emit(NoteLoaded(updatedNote));
//   }
// }
//
// void _onUpdateNoteContent(UpdateNoteContent event, Emitter<NoteState> emit) {
//   if (state is NoteEmpty) {
//     final noteId = _notesService.addNote("", event.content);
//     final note = _notesService.getNoteById(noteId)!;
//     emit(NoteLoaded(note));
//   }
//   if (state is NoteModified) {
//     final currentState = state as NoteLoaded;
//     final updatedNote = currentState.note..content = event.content;
//     emit(NoteLoaded(updatedNote));
//   }
// }

// void _onInitializeNewNote(
//     InitializeNewNote event, Emitter<NoteState> emit) {
//   if (state is NoteInitial) {
//     final newNote = Note(
//       id: DateTime.now().toIso8601String(),
//       title: '',
//       content: '',
//     );
//     emit(NoteLoaded(newNote));
//   }
// }
//
//
// Future<void> _onAutoSaveNote(AutoSaveNote event, Emitter<NoteState> emit) async {
//   if (state is NoteLoaded) {
//     print('Note auto-saved!');
//   }
// }
}
