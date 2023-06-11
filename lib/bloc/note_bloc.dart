import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteBloc extends Cubit<NoteState> {
  bool isDark = true;

  NoteBloc() : super(NoteInitial());

  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeNoteState());
  }
}
