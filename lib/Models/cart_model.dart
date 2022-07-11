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

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      totalItems: json['stock'],
      createDate: json['createDate'],
      category: json['category'],
    );
  }
}
