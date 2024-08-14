import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novels/core/services/injection_container.dart';
import 'package:novels/src/authentication/presentation/cubit/author_cubit.dart';
import 'package:novels/src/authentication/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthorCubit>(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Novel Up',
          theme: ThemeData(
              useMaterial3: true,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: const HomeScreen()),
    );
  }
}
