import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project05/notes.dart';

class ApiServices {
  static const String baseUrl =
      'https://mad-course-rest-note-api.vercel.app/api/notes';

  Future<List<Notes>> fetchNotes() async {
    final rs = await http.get(Uri.parse(baseUrl));

    if (rs.statusCode == 200) {
      List<dynamic> body = jsonDecode(rs.body);
      return body.map((dynamic item) => Notes.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch notes');
    }
  }

  Future<Notes> createNote(Notes note) async {
    final rs = await http.post(Uri.parse(baseUrl),
        body: jsonEncode(note.toJson()),
        headers: {'Content-type': 'application/json'});
    if (rs.statusCode == 201 || rs.statusCode == 200) {
      return Notes.fromJson(jsonDecode(rs.body));
    } else {
      throw Exception("Failed create note");
    }
  }

  Future<Notes> updateNote(String id, Notes note) async {
    try {
      final rs = await http.put(Uri.parse('$baseUrl/$id'),
          body: json.encode(note.toJson()),
          headers: {'Content-type': 'application/json'});
      if (rs.statusCode == 200) {
        return Notes.fromJson(json.decode(rs.body));
      } else {
        throw Exception('Faild to update note');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future <void> deleteNote(String id) async{
    try{
      final rs = await http.delete(Uri.parse('$baseUrl/$id'));
      if(rs.statusCode != 200){
        throw Exception('Failed to delete note');
      }
    }catch(e){
      throw Exception('$e');
    }
  }
}
