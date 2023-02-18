import 'package:api_app/cubits/note_list_cubit.dart';
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
    NoteUtils().getNotes().then((value) async {
      notes = value;
      context.read<NoteListCubit>().onLoad(notes!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoteListCubit, NoteListState>(
        builder: (context, state) {
          if (state is NoteList) {
            notes = (state as NoteList).notes;
          }
          return ListView.builder(
            itemCount: notes!.length,
            itemBuilder: (context, index) => Card(
              color: Colors.amberAccent,
              child: ListTile(
                title: Text(notes!.elementAt(index).name),
                subtitle: Text(notes!.elementAt(index).text),
              ),
            ),
          );
        },
      ),
    );
  }
}
