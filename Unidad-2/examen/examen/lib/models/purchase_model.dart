import 'cart_item_model.dart';

class Purchase {
  final List<CartItem> items;
  final DateTime date;

  double get total => items.fold(0, (sum, i) => sum + i.total);

  Purchase({required this.items, required this.date});

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        items: (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> toJson() => {'items': items.map((e) => e.toJson()).toList(), 'date': date.toIso8601String()};
}
