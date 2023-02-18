import 'package:api_app/cubits/note_list_cubit.dart';
import 'package:api_app/pages/note_create_edit_page.dart';
import 'package:api_app/utils/note_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  State<NoteScreen> createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  List<Note>? notes;

  @override
  void initState() {
    notes = List.empty();
    NoteUtils().getNotes(filter: filter).then((value) async {
      notes = value;
      context.read<NoteListCubit>().onLoad(notes!);
    });
    super.initState();
  }

  String filter = "";

  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 114, 139, 207),
        title: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: TextField(
              controller: searchController,
              onSubmitted: (value) => NoteUtils()
                  .getNotes(filter: filter, search: value)
                  .then((value) async {
                notes = value;
                context.read<NoteListCubit>().onLoad(notes!);
              }),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: ElevatedButton(
                    onPressed: () {
                      searchController.text = "";
                      NoteUtils().getNotes(filter: filter).then((value) async {
                        notes = value;
                        context.read<NoteListCubit>().onLoad(notes!);
                      });
                    },
                    child: Icon(Icons.close)),
                prefixIcon: PopupMenuButton(
                  tooltip: "Сортировка",
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Добавленные"),
                      onTap: () {
                        filter = '';
                        NoteUtils()
                            .getNotes(filter: filter)
                            .then((value) async {
                          notes = value;
                          context.read<NoteListCubit>().onLoad(notes!);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("Удаленные"),
                      onTap: () {
                        filter = 'deleted';
                        NoteUtils()
                            .getNotes(filter: filter)
                            .then((value) async {
                          notes = value;
                          context.read<NoteListCubit>().onLoad(notes!);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("Все"),
                      onTap: () {
                        filter = 'all';
                        NoteUtils()
                            .getNotes(filter: filter)
                            .then((value) async {
                          notes = value;
                          context.read<NoteListCubit>().onLoad(notes!);
                        });
                      },
                    ),
                  ],
                  icon: const Icon(Icons.filter_alt, color: Colors.white),
                ),
                hintText: 'Поиск',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteCreateEditPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteListCubit, NoteListState>(
        builder: (context, state) {
          if (state is NoteList) {
            notes = (state as NoteList).notes;
          }
          return ListView.builder(
            itemCount: notes!.length,
            itemBuilder: (context, index) => Card(
              color: Color.fromARGB(255, 167, 205, 219),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteCreateEditPage(
                              note: notes!.elementAt(index))));
                },
                title: Text(notes!.elementAt(index).name),
                subtitle: Text(notes!.elementAt(index).text),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          NoteUtils()
                              .deleteNote(notes!.elementAt(index))
                              .then((success) {
                            if (success) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                "Заметка успешно удалена",
                                textAlign: TextAlign.justify,
                              )));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                "Ошибка удаления заметки",
                                textAlign: TextAlign.justify,
                              )));
                            }
                            NoteUtils()
                                .getNotes(filter: filter)
                                .then((value) async {
                              notes = value;
                              context.read<NoteListCubit>().onLoad(notes!);
                            });
                          });
                        },
                        child: const Icon(Icons.delete)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
