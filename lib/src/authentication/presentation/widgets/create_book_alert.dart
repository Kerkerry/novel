import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novel/src/authentication/presentation/book/bloc/book_bloc.dart';

class CreateBookAlert extends StatelessWidget {
  const CreateBookAlert({
    super.key,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
  });

  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController author;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: const Text('Add Book'),
          content: SingleChildScrollView(
              child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration:
                      const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                      labelText: "Description"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                    controller: author,
                    decoration: const InputDecoration(
                        labelText: "Author")),
              ],
            ),
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                
                context.read<BookBloc>().add(CreateBookEvent(
                    title: title.text,
                    description: description.text,
                    author: author.text,
                    createdAt: createdAt.toIso8601String()));
                title.clear();
                description.clear();
                author.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}
