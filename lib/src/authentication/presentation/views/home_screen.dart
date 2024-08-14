import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novel/src/authentication/presentation/book/bloc/book_bloc.dart';
import 'package:novel/src/authentication/presentation/widgets/book_widget.dart';
import 'package:novel/src/authentication/presentation/widgets/create_book_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  final author = TextEditingController();
  final createdAt = DateTime.now();

  

  void getBooks() {
    context.read<BookBloc>().add(const CheckInternetConnectionEvent());
  }
  

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if (state is InternetConnectedState) {
          context.read<BookBloc>().add(const GetBooksEvent());
        }

        if (state is BookErrorState) {
          final messageSection = state.message.substring(0, 15);
          if (messageSection == "ClientException") {
            context.read<BookBloc>().add(const CheckInternetConnectionEvent());
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is BookCreatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Book created succesfully")));
          getBooks();
        }

        if (state is BookUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Book updated succesfully")));
          getBooks();
        }

        if (state is BookDeletedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Book deleted")));
          getBooks();
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Novel up"),
              centerTitle: true,
            ),
            body: state is GettingBooksState?
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is BooksLoadedState
                    ? state.books.isEmpty
                        ? const Center(
                            child: Text(
                              "There are no books, \nUse the add button\nTo add one or more :)",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.books.length,
                            itemBuilder: (context, index) {
                              final book = state.books[index];
                              return BookWidget(
                                  title: title,
                                  book: book,
                                  description: description,
                                  author: author);
                            })
                    : state is InternetNotConnectedState
                        ? SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 200,
                                  height: 70,
                                  child: Icon(
                                    Icons.wifi_off_outlined,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "No internet",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<BookBloc>().add(
                                          const CheckInternetConnectionEvent());
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                      size: 32,
                                    ))
                              ],
                            ))
                        : const SizedBox(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context
                    .read<BookBloc>()
                    .add(const CheckInternetConnectionEvent());
                if (state is InternetNotConnectedState) return;
                title.clear();
                description.clear();
                author.clear();
                showDialog(
                    context: context,
                    builder: ((context) {
                      return CreateBookAlert(
                          title: title,
                          description: description,
                          author: author,
                          createdAt: createdAt);
                    }));
              },
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
