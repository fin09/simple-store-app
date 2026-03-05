import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_porducts_service.dart';
import 'package:store_app/services/update_product.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await GetAllProductsService().getAllProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
    required int productID,
  }) async {
    try {
      await UpdateProductService().updateProduct(
        title: title,
        price: price,
        description: description,
        image: image,
        productID: productID,
        category: category,
      );

      // Locally update the product in the list for immediate UI response
      final index = _products.indexWhere((p) => p.id == productID);
      if (index != -1) {
        // Assuming the server returns the updated product or we just update our local model
        // If the server returns full JSON, we can use ProductModel.fromJson
        // For now, let's just refresh the whole list to be safe and consistent with server state
        await fetchProducts();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
