import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/create_publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/get_publisher.dart';

part 'publisher_event.dart';
part 'publisher_state.dart';

class PublisherBloc extends Bloc<PublisherEvent, PublisherState> {
  final CreatePublisher _createPublisher;
  final GetPublisher _getPublisher;
  PublisherBloc({required CreatePublisher createPublisher, required GetPublisher getPublisher}) : 
  _createPublisher=createPublisher,
  _getPublisher=getPublisher,
  super(PublisherInitial()) {
   on<CreatePublisherEvent>(_createPublisherHandler);
   on<GetPublisherEvent>(_getPublisherHandler);
  }

  Future<void> _createPublisherHandler(CreatePublisherEvent event, Emitter<PublisherState> emit)async{
    emit(const CreatingPublisherState());
    final result=await _createPublisher(PublisherParams(name: event.name, email: event.email, city: event.city, country: event.country));

    result.fold((failure) => emit(PublisherErrorState(failure.message)), (_) => emit(const PublisherCreatedState()));
  }

  Future<void> _getPublisherHandler(GetPublisherEvent event, Emitter<PublisherState> emit)async{
    emit(const GetPublisherState());
    final result=await _getPublisher();
    result.fold((failure) => emit(PublisherErrorState(failure.message)), (publishers) => emit(PublisherLoadedState(publishers)));
  }
}
