class CartModel {
  int id;
  String name;
  String image;
  double price;
  int totalItems;
  int createDate;
  List category;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.totalItems,
    required this.createDate,
    required this.category,
  });
}
