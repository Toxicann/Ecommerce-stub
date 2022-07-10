class ProductModel {
  int id;
  String name;
  String image;
  String price;
  int stock;
  int createDate;
  List category;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.stock,
    required this.createDate,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      stock: json['stock'],
      createDate: json['createDate'],
      category: json['category'],
    );
  }
}
