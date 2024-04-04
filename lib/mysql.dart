import 'package:mysql1/mysql1.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MySql
{
  static String _host = 'localhost',
                _user = 'adamdien_grocery',
                _pass = "reparetekmogyoro",
                _db = 'adamdien_grocery';

  static int _port = 3306;

  MySql();


  Future<MySqlConnection> getConnection() async
  {
    dotenv.load(fileName: "assets/.env");

    print(dotenv.env['DB_HOST']);
    var settings = new ConnectionSettings(
      host: dotenv.env['DB_HOST'] ?? _host,
      port: dotenv.env['DB_PORT'] != null ? int.parse(dotenv.env['DB_PORT']!) : _port,
      user: dotenv.env['DB_USER'] ?? _user,
      password: dotenv.env['DB_PASS'] ?? _pass,
      db: dotenv.env['DB_NAME'] ?? _db,
    );

    return await MySqlConnection.connect(settings);
  }
}