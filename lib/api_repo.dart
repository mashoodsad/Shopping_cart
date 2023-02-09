
import 'package:samplejsonbloc/Product.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Product> fetchProductList() {
    return _provider.fetchProviderList();
  }
}

class NetworkError extends Error {}