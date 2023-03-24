import 'package:foody/data/models/product_model.dart';

class CartModel {
  static final List<ProductModel> _carts = List.empty(growable: true);

  void addToCart({required ProductModel productModel}) {
    _carts.add(productModel);
  }

  List<ProductModel> getCart() {
    return _carts;
  }
}