import 'package:elysium/models/elysium_user.dart';
import 'package:elysium/services/note_service.dart';
import 'package:elysium/utils/styles.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, required this.elysiumUser}) : super(key: key);

  final ElysiumUser elysiumUser;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final TextEditingController contentController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
  late Note activeNote;
  Color noteItemColour = Styles.lightGrey;

  @override
  void initState() {
    super.initState();
    activeNote = NoteService.createNote("Untitled", "", widget.elysiumUser);
    setActiveNote(activeNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 256,
            height: MediaQuery.of(context).size.height,
            color: Styles.lightGrey,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Styles.mediumGrey,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                            String noteTitle = NoteService.generateNoteTitle(widget.elysiumUser.notes);
                            setState(() {
                              activeNote = NoteService.createNote(noteTitle, "", widget.elysiumUser);
                              setActiveNote(activeNote);
                            });
                        },
                        icon: const Icon(
                          Icons.book,
                          color: Styles.mediumGrey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    child: Column(
                      children: [
                        for (Note note in widget.elysiumUser.notes)
                          MouseRegion(
                            onEnter: (isEnter) {
                              setState(() {
                                noteItemColour = Styles.lightMediumGrey;    
                              });
                            },
                            onExit: (isExit) {
                              setState(() {
                                noteItemColour = Styles.lightGrey;    
                              });                          
                            },
                            child: GestureDetector(
                              onTap: () {                            
                                setState(() {
                                  activeNote = note;
                                  contentController.text = note.content;
                                  titleController.text = note.title;
                                });
                              },
                              child: Container(
                                height: 32,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: noteItemColour,
                                  borderRadius: BorderRadius.circular(Styles.borderRadius),
                                  border: Border.all(color: Styles.lightGrey),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      note.title.length > 20 ? note.title.substring(0,20) + "..." : note.title,
                                      style: TextStyle(
                                        color: Styles.mediumGrey,
                                        fontWeight: activeNote == note ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 8 - 64),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "take note...",
                      style: Styles.titleTextStyle,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Styles.mediumGrey),
                      borderRadius: BorderRadius.circular(Styles.borderRadius),
                      color: Styles.lightGrey,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          onChanged: (isChanged) {
                            NoteService.updateNote(titleController.text, activeNote);
                            activeNote.title = activeNote.content.split('\n')[0];                        
                            setState(() {});
                          },
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                            hintText: "Write here.",
                          ),
                          style: const TextStyle(
                            color: Styles.darkGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                          controller: contentController,
                          onChanged: (isChanged) {
                            NoteService.updateNote(contentController.text, activeNote);
                            setState(() {});
                          },
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                            hintText: "Write here.",
                          ),
                          style: const TextStyle(color: Styles.mediumGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void setActiveNote(Note note) {
    activeNote = note;
    titleController.text = note.title;
    contentController.text = note.content;
  }
}