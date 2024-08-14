part of 'publisher_bloc.dart';

sealed class PublisherEvent extends Equatable {
  const PublisherEvent();

  @override
  List<Object> get props => [];
}

class CreatePublisherEvent extends PublisherEvent{
  final String name;
  final String email;
  final String city;
  final String country;
  const CreatePublisherEvent({required this.name,required this.email, required this.city,required this.country});
  @override
  List<String> get props=>[name,email,city, country];
}

class GetPublisherEvent extends PublisherEvent{
  const GetPublisherEvent();
}
