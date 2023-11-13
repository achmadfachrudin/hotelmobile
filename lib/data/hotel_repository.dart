import 'dart:async';

import '../domain/model/search_result.dart';
import '../domain/model/search_result_item.dart';

final savedResults = SearchResult(
  items: [
    SearchResultItem(
      id: "F1",
      name: 'favehotel Margonda',
      imageUrl:
          'https://imageresizer.arch.software/favehotels/v1/FaveJababeka/Gallery/faveJababeka_LobbyLounge.jpg',
      street: 'Jl. Margonda Depok',
      rate: 3,
      price: BigInt.from(10000),
    ),
    SearchResultItem(
      id: "F2",
      name: 'favehotel Jabebeka Cikarang',
      imageUrl:
          'https://imageresizer.arch.software/favehotels/v1/FaveJababeka/Gallery/faveJababeka_LobbyLounge.jpg',
      street: 'Jl. Cikarang',
      rate: 4,
      price: BigInt.from(10000),
    ),
    SearchResultItem(
      id: "F4",
      name: 'favehotel Braga Bandung',
      imageUrl:
          'https://imageresizer.arch.software/favehotels/v1/FaveJababeka/Gallery/faveJababeka_LobbyLounge.jpg',
      street: 'Jl. Braga Bandung',
      rate: 4,
      price: BigInt.from(10000),
    ),
    SearchResultItem(
      id: "F5",
      name: 'Aston Bandung',
      imageUrl:
          'https://imageresizer.arch.software/favehotels/v1/FaveJababeka/Gallery/faveJababeka_LobbyLounge.jpg',
      street: 'Jl. Braga Bandung',
      rate: 4,
      price: BigInt.from(10000),
    ),
    SearchResultItem(
      id: "F6",
      name: 'favehotel PGC Cililitan',
      imageUrl:
          'https://imageresizer.arch.software/favehotels/v1/FaveJababeka/Gallery/faveJababeka_LobbyLounge.jpg',
      street: 'Jl. Cililitan Jakarta Timur',
      rate: 3,
      price: BigInt.from(10000),
    ),
    SearchResultItem(
      id: "F7",
      name: 'favehotel Kelapa Gading',
      imageUrl:
          'https://imageresizer.arch.software/favehotels/v1/FaveJababeka/Gallery/faveJababeka_LobbyLounge.jpg',
      street: 'Jl. Raya Gading Indah Jakarta Utara',
      rate: 4,
      price: BigInt.from(10000),
    ),
  ],
);

class HotelRepository {
  Future<SearchResult> search(String queries) async {
    List<SearchResultItem> localItems = savedResults.items;

    final keywords = queries.split(" ");

    final filteredList = localItems.where((item) {
      final fullKey = "${item.name.toLowerCase()} ${item.street.toLowerCase()}";
      // only displays those containing all keywords
      return keywords.every((keyword) => fullKey.contains(keyword));
    }).toList();

    final searchResult = SearchResult(items: filteredList);

    return searchResult;
  }
}
