import 'package:store_app/helper/api.dart';

class UpdateProductService {
  Api api = Api();
  Future<dynamic> updateProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required productID,
    required String category,
  }) async {
    return await api.put(
      id: productID.toString(),
      url: 'http://10.0.2.2:3000/products',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
        'rating': {
          'rate': 4.5,
          'count': 100,
        },
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
    );
  }
}
