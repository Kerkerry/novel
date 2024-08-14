import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novels/src/authentication/presentation/cubit/author_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getAuthors() {
    context.read<AuthorCubit>().getAuthors();
  }

  @override
  void initState() {
    getAuthors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorCubit, AuthorState>(
      listener: (context, state) {
        if (state is AuthorError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AuthorCreatedState) {
          getAuthors();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(("Home")),
          ),
          body: state is GetAuthorsState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is AuthorsLoaded
                  ? ListView(
                      children: const [Text("Authors Loaded")],
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
