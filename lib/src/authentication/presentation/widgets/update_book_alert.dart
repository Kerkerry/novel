

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novel/src/authentication/data/model/book_model.dart';
import 'package:novel/src/authentication/domain/entities/book.dart';
import 'package:novel/src/authentication/presentation/book/bloc/book_bloc.dart';

class UpdateBookAlert extends StatelessWidget {
  const UpdateBookAlert({
    super.key,
    required this.title,
    required this.description,
    required this.author,
    required this.book,
  });

  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController author;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: const Text('Update Book'),
          content: SingleChildScrollView(
              child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration:
                      const InputDecoration(
                          labelText: "Title"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: description,
                  decoration:
                      const InputDecoration(
                          labelText:
                              "Description"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                    controller: author,
                    decoration:
                        const InputDecoration(
                            labelText:
                                "Author")),
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
              child: const Text('Update'),
              onPressed: () {
                final booktoUpdate = BookModel(
                    id: book.id,
                    title: title.text,
                    description:
                        description.text,
                    author: author.text,
                    createdAt: book.createdAt);
                context.read<BookBloc>().add(
                    UpdateBookEvent(
                        booktoUpdate));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}
