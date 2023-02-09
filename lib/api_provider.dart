import 'package:dio/dio.dart';
import 'package:samplejsonbloc/Product.dart';



class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'http://174.138.121.52:3009/v1/product/getAllProduct';

  Future<Product> fetchProviderList() async {
    try {
      Response response = await _dio.get(_url);
      return Product.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Product.fromJson("Data not found / Connection issue");
    }
  }
}