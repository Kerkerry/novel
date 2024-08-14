part of 'publisher_bloc.dart';

sealed class PublisherState extends Equatable {
  const PublisherState();
  
  @override
  List<Object> get props => [];
}

final class PublisherInitial extends PublisherState {}

class PublisherCreatedState extends PublisherState{
  const PublisherCreatedState();
}

class CreatingPublisherState extends PublisherState{
  const CreatingPublisherState();
}

class GetPublisherState extends PublisherState{
  const GetPublisherState();
}

class PublisherLoadedState extends PublisherState{
  final List<Publisher> publishers;
  const PublisherLoadedState(this.publishers);
  @override
  List<String> get props=>publishers.map((publisher) => publisher.id).toList();
}

class PublisherErrorState extends PublisherState{
  final String message;
  const PublisherErrorState(this.message);

}