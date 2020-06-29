import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cesta/model/usuario.dart';

class LoginApi {
  // ignore: missing_return
  static Future<Usuario> login(String login, String senha) async {
    try {
      //Usuario pessoa = new Usuario();

      var url = 'http://192.168.0.37:8080/login';

      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {"username": login, "password": senha};

      //var prefs = await SharedPreferences.getInstance();

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();

        return user;
      }
    } catch (error, exception) {
      print("ERRO LOGIN>>>>>>>>>>>>>>>>>>>>>>> $error> $exception");
    }
  }
}
