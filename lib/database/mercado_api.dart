import 'dart:convert' as convert;
import 'package:cesta/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:cesta/model/mercado.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MercadoApi {
  static Future<List<Mercado>> getMercado() async {
    List<Mercado> produtos;
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer ${user.token}"
      };

    var url = 'http://192.168.0.37:8080/mercado/';

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);
    produtos = List<Mercado>();
    for (Map map in list) {
      Mercado mercadinhos = Mercado.fromJson(map);
      produtos.add(mercadinhos);
    }
    return produtos;
  }
}
