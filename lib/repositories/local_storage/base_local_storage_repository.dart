import 'package:hive/hive.dart';
import '../../models/product_model.dart';

abstract class BaseLocalStorageRepository{
  Future<Box> openBox();
  List<Product> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductFromWishList(Box box, Product product);
  Future<void> clearWishlist(Box box);
}