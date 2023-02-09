class Data {
  Data({
      required this.id,
      required this.name,
      required this.brand,
      required this.image,
      required this.price,
      required this.description,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
  }
late int id;
  late String name;
  late String brand;
  late String image;
  late String price;
  late String description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['brand'] = brand;
    map['image'] = image;
    map['price'] = price;
    map['description'] = description;
    return map;
  }

}