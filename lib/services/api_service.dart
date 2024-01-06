/// The above class is an ApiService class  that fetches data from an API and returns a list of
/// ApiModel objects.
import 'dart:convert';
import 'package:fetchapi/apimodel/model_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// The line `static const apiurl = 'https://fakestoreapi.com/products';` is declaring a static
  /// constant variable named `apiurl` with the value `'https://fakestoreapi.com/products'`. This
  /// variable is used to store the URL of the API endpoint from which data will be fetched. The
  /// `static` keyword means that the variable belongs to the class itself rather than an instance of
  /// the class, and the `const` keyword means that the value of the variable is a compile-time constant
  /// and cannot be changed during runtime.
  static const apiurl = 'https://fakestoreapi.com/products';

  /// The function `getPost` retrieves a list of `ApiModel` objects from an API endpoint.
  ///
  /// Returns:
  ///   a Future object that resolves to a List of ApiModel objects.
  Future<List<ApiModel>> getPost() async {
    List<ApiModel> posts = [];
    try {
      Uri url = Uri.parse(apiurl);
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> post = jsonDecode(response.body);
        for (var items in post) {
          ApiModel postsList = ApiModel.fromMap(items);
          posts.add(postsList);
        }
      }
      return posts;
    } catch (e) {
      throw Exception(e);
    }
  }
}
