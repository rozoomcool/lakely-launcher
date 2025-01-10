part of "note_bloc.dart";

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNote extends NoteEvent {
  final int? noteId;

  const LoadNote(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

class InitializeNewNote extends NoteEvent {
  const InitializeNewNote();
}

class UpdateNote extends NoteEvent {
  final String? title;
  final String? content;

  const UpdateNote(this.title, this.content);

  @override
  List<Object?> get props => [title, content];
}

class UpdateNoteTitle extends NoteEvent {
  final String title;

  const UpdateNoteTitle(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdateNoteContent extends NoteEvent {
  final String content;

  const UpdateNoteContent(this.content);

  @override
  List<Object?> get props => [content];
}

class AutoSaveNote extends NoteEvent {
  const AutoSaveNote();
}

class SaveNote extends NoteEvent {
  const SaveNote();
}
