import 'package:api_app/utils/api_utils.dart';
import 'package:dio/dio.dart';

import '../models/note.dart';

class NoteUtils {
  Future<List<Note>> getNotes() async {
    try {
      final notes = await ApiUtils.S!.dio.get("/notes");
      return (notes.data["data"] as List)
          .map((note) => Note.fromJson(note))
          .toList();
    } on DioError catch (error) {
      return List.empty();
    }
  }
}
