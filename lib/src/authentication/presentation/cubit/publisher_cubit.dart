import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/create_publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/get_publisher.dart';

part 'publisher_state.dart';

class PublisherCubit extends Cubit<PublisherState> {
  final CreatePublisher _createPublisher;
  final GetPublisher _getPublisher;
  PublisherCubit({required CreatePublisher createPublisher,required GetPublisher getPublisher}) : 
  _createPublisher=createPublisher,
  _getPublisher=getPublisher,
  super(PublisherInitial());

  Future<void> createPublisher({required String name,required String email,required String city,required String country})async{
    emit(const CreatingPublisherState());
    final result=await _createPublisher(PublisherParams(name: name, email: email, city: city, country: country));
    result.fold((failure) => emit(PublisherErrorState(failure.message)), (_) => emit(const PublisherCreatedState()));
  }

  Future<void> getPublisher()async{
    emit(const GetPublisherState());
    final result=await _getPublisher();
    result.fold((failure) => emit(PublisherErrorState(failure.message)), (publishers) => emit(PublisherLoadedState(publishers)));
  }
}
