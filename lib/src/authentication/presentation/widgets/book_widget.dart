import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novel/src/authentication/domain/entities/book.dart';
import 'package:novel/src/authentication/presentation/book/bloc/book_bloc.dart';
import 'package:novel/src/authentication/presentation/widgets/update_book_alert.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.title,
    required this.book,
    required this.description,
    required this.author,
  });

  final TextEditingController title;
  final Book book;
  final TextEditingController description;
  final TextEditingController author;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      return ListTile(
        minVerticalPadding: 30,
        leading: IconButton(
            onPressed: () {
              context
                  .read<BookBloc>()
                  .add(const CheckInternetConnectionEvent());
              title.text = book.title;
              description.text = book.description;
              author.text = book.author;
              showDialog(
                context: context,
                builder: ((context) => UpdateBookAlert(
                    title: title,
                    description: description,
                    author: author,
                    book: book)),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            )),
        title: Text(book.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.description),
            const SizedBox(
              height: 5,
            ),
            Text("Created: ${book.createdAt} \nAuthor: ${book.author}")
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No")),
                        TextButton(
                            onPressed: () {
                              context
                                  .read<BookBloc>()
                                  .add(const CheckInternetConnectionEvent());
                              context
                                  .read<BookBloc>()
                                  .add(DeleteBookEvent(book.id));
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"))
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      );
    });
  }
}
