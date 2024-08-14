import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novel/core/connection_helper.dart';
import 'package:novel/src/authentication/data/model/book_model.dart';
import 'package:novel/src/authentication/domain/entities/book.dart';
import 'package:novel/src/authentication/domain/usecases/create_book.dart';
import 'package:novel/src/authentication/domain/usecases/delete_book.dart';
import 'package:novel/src/authentication/domain/usecases/get_books.dart';
import 'package:novel/src/authentication/domain/usecases/update_book.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final CreateBook _createBook;
  final GetBooks _getBooks;
  final DeleteBook _deleteBook;
  final UpdateBook _updateBook;
  final InternetConnectionHelper _internetConnnection;

  BookBloc({required CreateBook createBook,required GetBooks getBooks, required DeleteBook deleteBook, required UpdateBook updateBook, required InternetConnectionHelper internetConnection}) : 
  _createBook=createBook,
  _getBooks=getBooks,
  _deleteBook=deleteBook,
  _updateBook=updateBook,
  _internetConnnection=internetConnection,
  super(BookInitial()) {
   on<CreateBookEvent>(_createBookHndler);
   on<GetBooksEvent>(_getBooksHandler);
   on<UpdateBookEvent>(_updateBookHandler);
   on<DeleteBookEvent>(_deleteBookHndler);
   on<CheckInternetConnectionEvent>(_internetConnnectionHandler);
  }

  Future<void> _createBookHndler(CreateBookEvent event, Emitter<BookState> emit)async{
    emit(const CreatingBookState());
    final result=await _createBook(BookParams(title: event.title, description: event.description, author: event.author, createdAt: event.createdAt));
    
    result.fold((failure) {
      emit(BookErrorState(failure.message));
    }, (_) =>emit(const BookCreatedState()) );
  }

  Future<void> _getBooksHandler(GetBooksEvent event, Emitter<BookState> emit)async{
    emit(const GettingBooksState());
    final result=await _getBooks();
    result.fold((failure) => emit(BookErrorState(failure.message)), (books) => emit(BooksLoadedState(books)));
  }

  FutureOr<void> _updateBookHandler(UpdateBookEvent event, Emitter<BookState> emit) async{
    emit(const UpdatingBookState());
    final result=await _updateBook(event.updatedBook);

    result.fold((failure) => emit(BookErrorState(failure.message)), (_) => emit(const BookUpdatedState()));
  }

  Future<void> _deleteBookHndler(DeleteBookEvent event, Emitter<BookState> emit)async{
    emit(const DeletingBookState());
    final result=await _deleteBook(event.id);

    result.fold((failure) => emit(BookErrorState(failure.message)), (_) => emit(const BookDeletedState()));
  }


  FutureOr<void> _internetConnnectionHandler(CheckInternetConnectionEvent event, Emitter<BookState> emit) async{
    final  connetionResult=await _internetConnnection.checkInternetConnection();
    if(connetionResult){
      emit( InternetConnectedState(connetionResult));
    }else{
      emit( InternetNotConnectedState(connetionResult));
    }
  }
}
