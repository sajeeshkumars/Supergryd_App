

import 'package:mynewpackage/productt_response.dart';

import 'data_source.dart';

class ProductRepo{
  ProductDataSource productDataSource = ProductDataSource();
  Future<ProducttResponse>getProducts()async{
    return productDataSource.getProducts();
  }
}