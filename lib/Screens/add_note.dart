import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project05/Screens/home.dart';
import 'package:project05/api_services.dart';
import 'package:project05/notes.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final ApiServices _apiServices = ApiServices();

  TextEditingController newTitle = TextEditingController();
  TextEditingController newContent = TextEditingController();

  void _addNote() async {
    final Notes newNote =
        Notes(id: '', title: newTitle.text, content: newContent.text);
    await _apiServices.createNote(newNote);

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0FE937),
        title: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(
            'Add',
            style: GoogleFonts.poppins(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Container(
              color: Colors.amber.shade50,
              child: TextField(
                keyboardType: TextInputType.name,
                controller: newTitle,
                decoration: const InputDecoration(
                  hintText: "Enter New Title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: const Color(0xFFFFF8E1),
              child: TextField(
                keyboardType: TextInputType.name,
                controller: newContent,
                decoration: const InputDecoration(
                  hintText: "Enter New Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            MaterialButton(
              onPressed: () {
                _addNote();
              },
              color: const Color(0xff0FE937),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Add",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
