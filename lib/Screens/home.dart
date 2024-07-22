import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project05/Screens/add_note.dart';
import 'package:project05/Screens/update_note.dart';
import 'package:project05/api_services.dart';
import 'package:project05/notes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Notes>> _notes;
  final ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    _notes = _apiServices.fetchNotes();
  }

  void _deleteNotes(String id) async {
    await _apiServices.deleteNote(id);
    setState(() {
      _notes = _apiServices.fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNote()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff569FFE),
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: _notes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("No notes found",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 86, 89, 254))),
                    );
                  }

                  final notes = snapshot.data!;
                  return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return Card(
                          color: Colors.amber.shade50,
                          child: ListTile(
                            title: Text(note.title,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff569FFE))),
                            subtitle: Text(note.content,
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(255, 0, 0, 0))),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateNote(note: note)));
                            },
                            trailing: IconButton(
                                onPressed: () => _deleteNotes(note.id),
                                icon: const Icon(Icons.delete)),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
