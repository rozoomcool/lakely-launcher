import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lakely/domain/entity/notes.dart';
import 'package:lakely/domain/service/notes_service.dart';

part 'note_state.dart';

part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesService _notesService;

  NoteBloc(this._notesService) : super(const NoteState.empty()) {
    on<LoadNote>(_onLoadNote);
    on<UpdateNote>(_onUpdateNote);
    on<SaveNote>(_onSaveNote);
  }

  Future<void> _onLoadNote(LoadNote event, Emitter<NoteState> emit) async {
    emit(state.copyToLoading());
    try {
      if (event.noteId == null) {
        emit(const NoteState.empty());
        return;
      }

      final note = _notesService.getNoteById(event.noteId!);
      if (note == null) {
        emit(state.copyToError("Заметка не найдена"));
        return;
      }

      emit(state.copyToLoaded(note));
    } catch (e) {
      emit(state.copyToError('Не удалось загрузить заметку.'));
    }
  }

  void _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) {
    if (state.note == null) {
      // Создаем новую заметку, если она еще не существует
      final noteId =
          _notesService.addNote(event.title ?? "", event.content ?? "");
      final note = _notesService.getNoteById(noteId)!;
      emit(state.copyToLoaded(note));
    } else {
      // Обновляем текущую заметку
      final updatedNote = state.note!
        ..title = event.title ?? state.note!.title
        ..content = event.content ?? state.note!.content;
      emit(state.copyWith(note: updatedNote, isModified: true));
    }
  }

  Future<void> _onSaveNote(SaveNote event, Emitter<NoteState> emit) async {
    if (state.note != null && state.isModified) {
      try {
        final updated = _notesService.updateNote(
          state.note!.id,
          title: state.note!.title,
          content: state.note!.content,
        );

        if (updated) {
          final note = _notesService.getNoteById(state.note!.id)!;
          emit(state.copyToLoaded(note));
        } else {
          emit(state.copyToError("Не удалось сохранить заметку."));
        }
      } catch (e) {
        emit(state.copyToError("Ошибка при сохранении заметки."));
      }
    }
  }
}
