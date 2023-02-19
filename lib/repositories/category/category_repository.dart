import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/repositories/category/base_category_repository.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryRepository extends BaseCategoryRepository{
  final FirebaseFirestore _firebaseFirestore;
  CategoryRepository({FirebaseFirestore? firebaseFirestore})
      :_firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Category>> getAllCategory() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }

}