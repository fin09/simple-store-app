import 'package:store_app/helper/api.dart';

class GetAllCategoriesService {
  Api api = Api();
  Future<List<dynamic>> getAllCategories() async {
    return await api.get(url: 'http://10.0.2.2:3000/categories');
  }
}
