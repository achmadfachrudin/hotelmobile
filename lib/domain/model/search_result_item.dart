
class SearchResultItem {
  final String id;

  final String name;

  final String imageUrl;

  final String street;

  final int rate;

  final BigInt price;

  SearchResultItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.street,
    required this.rate,
    required this.price,
  });

  static SearchResultItem fromJson(dynamic json) {
    return SearchResultItem(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      street: json['street'] as String,
      rate: json['rate'] as int,
      price: json['price'] as BigInt,
    );
  }
}
