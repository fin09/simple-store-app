import 'package:store_app/helper/api.dart';
import '../models/product_model.dart';

class GetAllProductsService {
  Api api = Api();
  Future<List<ProductModel>> getAllProducts() async {
    List<dynamic> products = await api.get(
      url: 'http://10.0.2.2:3000/products',
    );
    List<ProductModel> productsList = [];
    for (int i = 0; i < products.length; i++) {
      productsList.add(ProductModel.fromJson(products[i]));
    }
    return productsList;
  }
}
