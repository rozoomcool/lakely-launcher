part of "note_bloc.dart";

class NoteError extends Equatable {
  final String? message;

  const NoteError({this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class NoteState extends Equatable {
  const NoteState(this.note, this.isLoading, this.error, this.isModified);

  const NoteState.empty(
      {this.note, this.isLoading = false, this.error, this.isModified = false});

  final Note? note;
  final bool isLoading;
  final NoteError? error;
  final bool isModified;

  NoteState copyWith(
      {Note? note, bool? isLoading, NoteError? error, bool? isModified}) {
    return NoteState(note ?? this.note, isLoading ?? this.isLoading,
        error ?? this.error, isModified ?? this.isModified);
  }

  NoteState copyToError(String message) {
    return copyWith(
        error: NoteError(message: message),
        isLoading: false,
        isModified: false);
  }

  NoteState copyToLoading() {
    return copyWith(error: null, isLoading: true, isModified: false);
  }

  NoteState copyToModified() {
    return copyWith(error: null, isLoading: false, isModified: true);
  }

  NoteState copyToLoaded(Note note) {
    return copyWith(note: note, error: null, isLoading: false, isModified: true);
  }

  @override
  List<Object?> get props => [note, isLoading, error, isModified];
}
