import 'package:api_app/utils/api_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteUtils {
  Future<List<Note>> getNotes({String filter = "", String search = ""}) async {
    try {
      final notes = await ApiUtils.S!.dio.get("/notes", queryParameters: {"filter": filter, "search": search});
      if (notes.data["data"] == "") {
        return List.empty();
      }
      return (notes.data["data"] as List)
          .map((note) => Note.fromJson(note))
          .toList();
    } on DioError catch (error) {
      return List.empty();
    }
  }

  Future<bool> deleteNote(Note note) async {
    try {
      await ApiUtils.S!.dio.delete("/notes/" + note.number.toString());
      return true;
    } on DioError catch (error) {
      return false;
    }
  }

  Future<bool> updateNote(Note note) async {
    try {
      await ApiUtils.S!.dio.put("/notes/" + note.number.toString(), data: note);
      return true;
    } on DioError catch (error) {
      return false;
    }
  }

    Future<bool> createNote(Note note) async {
    try {
      await ApiUtils.S!.dio.post("/notes", data: note);
      return true;
    } on DioError catch (error) {
      return false;
    }
  }
}
