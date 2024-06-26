import 'package:http/http.dart' as http;

class ApiClient {
  static String _baseUrl =
      'https://grocery-app-server-8o3xk.ondigitalocean.app';
  static String _bearerToken = '9sOlQBvayE';

  ApiClient();

  Future<http.Response> getRequest(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $_bearerToken',
        },
      );
      return response;
    } catch (e) {
      print('API error: $e');
      return http.Response('Error: $e', 500);
    }
  }
}
