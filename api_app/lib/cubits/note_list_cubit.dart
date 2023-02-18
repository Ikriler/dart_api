import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/note.dart';

class NoteListCubit extends Cubit<NoteListState> {
  NoteListCubit() : super(NoteListInitial());

  void onLoad(List<Note> notes) {
    emit(NoteList(notes));
  }
}

@immutable
abstract class NoteListState {}

class NoteListInitial extends NoteListState {}

class NoteList extends NoteListState {
  late List<Note> notes;

  NoteList(this.notes);
}
