import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/hotel_repository.dart';
import '../../domain/model/search_result_error.dart';
import 'hotel_search_event.dart';
import 'hotel_search_state.dart';

class HotelSearchBloc extends Bloc<HotelSearchEvent, HotelSearchState> {
  HotelSearchBloc({
    required this.hotelRepository,
  }) : super(SearchStateEmpty()) {
    on<Viewed>(_onViewed);
    on<TextChanged>(_onTextChanged);
    on<SearchClicked>(_onSearchClicked);
  }

  final HotelRepository hotelRepository;

  var queries = '';

  void _onViewed(
    Viewed event,
    Emitter<HotelSearchState> emit,
  ) async {
    _doSearch(emit);
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<HotelSearchState> emit,
  ) async {
    queries = event.text;
  }

  void _onSearchClicked(
    SearchClicked event,
    Emitter<HotelSearchState> emit,
  ) async {
    _doSearch(emit);
  }

  void _doSearch(
    Emitter<HotelSearchState> emit,
  ) async {
    emit(SearchStateLoading());

    try {
      final results = await hotelRepository.search(queries);
      if (results.items.isEmpty) {
        emit(SearchStateEmpty());
      } else {
        emit(SearchStateSuccess(results.items));
      }
    } catch (error) {
      emit(error is SearchResultError
          ? SearchStateError(error.message)
          : const SearchStateError('something went wrong'));
    }
  }
}
