import 'Data.dart';

class Product {
  Product({
      required this.status,
      required this.data,});

  Product.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
 late String status;
  late List<Data> data;

  get error => null;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}