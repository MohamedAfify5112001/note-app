import 'package:hive/hive.dart';

import '../model/note_model.dart';

class BoxesNote {
  static Box<Note> getNote() => Hive.box<Note>("notes");
}

class NoQueriesFunction {
  static Future addNote(NoteParameters noteParameters) async {
    final note = Note()
      ..title = noteParameters.title
      ..content = noteParameters.content
      ..dateTime = noteParameters.dateTime
      ..color = noteParameters.color;
    final box = BoxesNote.getNote();
    box.add(note);
  }

  static Future editNote(Note note, String title, String content) async {
    note.title = title;
    note.content = content;
    note.save();
  }

  static Future deleteNote(Note note) async {
    note.delete();
  }
}

class NoteParameters {
  String title;

  String content;

  String dateTime;

  int color;

  NoteParameters(this.title, this.content, this.dateTime, this.color);
}
