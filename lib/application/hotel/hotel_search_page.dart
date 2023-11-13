import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/hotel_repository.dart';
import '../../domain/model/search_result_item.dart';
import 'hotel_search_bloc.dart';
import 'hotel_search_event.dart';
import 'hotel_search_state.dart';

class HotelSearchPage extends StatelessWidget {
  final HotelRepository hotelRepository;

  HotelSearchPage({Key? key})
      : hotelRepository = HotelRepository(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotel')),
      body: BlocProvider(
        create: (_) => HotelSearchBloc(hotelRepository: hotelRepository),
        child: Column(
          children: <Widget>[
            _SearchBar(),
            _SearchBody(),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textSearchController = TextEditingController();
  final _textDateController = TextEditingController(
      text: 'Fri, 27 Oct 2023 - Sat, 28 Oct 2023, 1 Night(s)');
  late HotelSearchBloc _hotelSearchBloc;

  @override
  void initState() {
    super.initState();
    _hotelSearchBloc = context.read<HotelSearchBloc>();
  }

  @override
  void dispose() {
    _textSearchController.dispose();
    _textDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _hotelSearchBloc.add(Viewed());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Book a Room",
          ),
          TextField(
            controller: _textSearchController,
            autocorrect: false,
            style: const TextStyle(fontSize: 14.0),
            onChanged: (text) {
              _hotelSearchBloc.add(TextChanged(text: text));
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.pin_drop),
              suffixIcon: GestureDetector(
                // onTap: _onGpsTapped,
                child: const Icon(Icons.gps_fixed),
              ),
              border: InputBorder.none,
              labelText: 'Where are you going?',
            ),
          ),
          TextField(
            controller: _textDateController,
            enabled: false,
            autocorrect: false,
            style: const TextStyle(fontSize: 14.0),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_month),
              border: InputBorder.none,
              labelText: 'Check-in Date',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _hotelSearchBloc.add(SearchClicked());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {
          return state.items.isEmpty
              ? const Text('No Results')
              : Expanded(child: _SearchResults(items: state.items));
        }
        return const Text('Please type a location to search');
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({Key? key, required this.items}) : super(key: key);

  final List<SearchResultItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({Key? key, required this.item}) : super(key: key);

  final SearchResultItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0)),
                child: Image.network(item.imageUrl,
                    width: 80, height: 100, fit: BoxFit.cover)),
            const SizedBox(width: 8.0),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name),
                Text(
                  item.street,
                  style: const TextStyle(fontSize: 10.0),
                ),
                Row(
                    children: List.generate(
                        item.rate,
                        (index) => const Icon(
                              Icons.star,
                              size: 12,
                            ))),
                const Text(
                  "Start from",
                  style: TextStyle(fontSize: 10.0),
                ),
                Text(
                  item.price.toString(),
                ),
              ],
            ),
          ],
        ));
  }
}
