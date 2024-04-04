import 'package:mysql1/mysql1.dart';

import 'package:http/http.dart' as http;

class ApiClient {
  static String _baseUrl = 'http://localhost:3000';
  static String _bearerToken = '123456';

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
      print('Error: $e');
      return http.Response('Error: $e', 500);
    }
  }

}
/*
class MySql {
  static String _host = '185.111.89.207';
  static String _user = 'adamdien_grocery';
  static String _pass = "reparetekmogyoro";
  static String _db = 'adamdien_grocery';
  static int _port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _pass,
      db: _db,
    );

    MySqlConnection connection = await MySqlConnection.connect(settings);
    return connection;
  }
}
 */