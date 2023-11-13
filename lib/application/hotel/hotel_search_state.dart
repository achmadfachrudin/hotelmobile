import 'package:equatable/equatable.dart';

import '../../domain/model/search_result_item.dart';


abstract class HotelSearchState extends Equatable {
  const HotelSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends HotelSearchState {}

class SearchStateLoading extends HotelSearchState {}

class SearchStateSuccess extends HotelSearchState {
  const SearchStateSuccess(this.items);

  final List<SearchResultItem> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends HotelSearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}