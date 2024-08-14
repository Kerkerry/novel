import 'package:novels/src/authentication/data/datasources/author_remote_datasource.dart';
import 'package:novels/src/authentication/data/repositories/author_repository_implementation.dart';
import 'package:novels/src/authentication/domain/repository/author_repository.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';
import 'package:novels/src/authentication/presentation/cubit/author_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

GetIt sl=GetIt.instance;

Future<void> init()async{
  // sl..registerFactory(() => AuthorCubit(createAuthor: sl(), getAuthors: sl()))
  // ..registerLazySingleton(() => CreateAuthor(sl()))
  // ..registerLazySingleton(() => GetAuthors(sl()))
  // ..registerLazySingleton<AuthorRepository>(() =>AuthorRepositoryimplementation(sl()))
  // ..registerLazySingleton<AuthorRemoteDataSource>(() => AuthorRemoteDataSourceImplementation(sl()))
  // ..registerLazySingleton(() => http.Client.new);
  sl.registerFactory(() => AuthorCubit(createAuthor: sl(), getAuthors: sl()));
  sl.registerLazySingleton(() => CreateAuthor(sl()));
  sl.registerLazySingleton(() => GetAuthors(sl()));
  sl.registerLazySingleton<AuthorRepository>(() =>AuthorRepositoryimplementation(sl()));
  sl.registerLazySingleton<AuthorRemoteDataSource>(() => AuthorRemoteDataSourceImplementation(sl()));
  sl.registerLazySingleton(() => http.Client.new);

}