import 'package:equatable/equatable.dart';

abstract class HotelSearchEvent extends Equatable {
  const HotelSearchEvent();
}

class Viewed extends HotelSearchEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SearchClicked extends HotelSearchEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TextChanged extends HotelSearchEvent {
  const TextChanged({required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
