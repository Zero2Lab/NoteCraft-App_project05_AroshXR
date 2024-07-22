import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project05/Screens/home.dart';
import 'package:project05/api_services.dart';
import 'package:project05/notes.dart';

class UpdateNote extends StatefulWidget {
  final Notes? note;
  const UpdateNote({super.key, this.note});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final ApiServices _apiServices = ApiServices();

  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateContent = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      updateTitle.text = widget.note!.title;
      updateContent.text = widget.note!.content;
    }
  }

  void _UpdateNote(Notes note) async {
    await _apiServices.updateNote(note.id, note);
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
        backgroundColor: const Color(0xffFF7410),
        title: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(
            'Home',
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
                controller: updateTitle,
                decoration: const InputDecoration(
                  hintText: "Edit Title",
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
                controller: updateContent,
                decoration: const InputDecoration(
                  hintText: "Edit Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            MaterialButton(
              onPressed: () {
                _UpdateNote(Notes(
                    id: widget.note!.id,
                    title: updateTitle.text,
                    content: updateContent.text));
              },
              color: const Color(0xffFF7410),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Update",
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
