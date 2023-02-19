import 'package:ecommerce/models/models.dart';

abstract class BaseProductRepository{
  Stream<List<Product>> getAllProducts();
}