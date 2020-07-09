import 'dart:convert' as convert;
import 'package:cesta/api_response.dart';
import 'package:cesta/database/mercado_dao.dart';
import 'package:cesta/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:cesta/model/mercado.dart';

class MercadoApi {
  static Future<List<Mercado>> getMercado() async {
    List<Mercado> produtos;
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'http://192.168.0.37:8080/mercado/';
    print("GET>>>>$url");

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);
    produtos = List<Mercado>();

    for (Map map in list) {
      Mercado mercadinhos = Mercado.fromJson(map);
      produtos.add(mercadinhos);
    }
    final dao = MercadoDAO();
    for (Mercado mer in produtos) {
      dao.save(mer);
    }

    return produtos;
  }

  static Future<ApiResponse<bool>> saveMercado(Mercado mercado) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'http://192.168.0.37:8080/mercado/';

    print("POST>>>>>>>>>>>  $url");

    String json = mercado.toJson();

    print("JSON > $json");

    var response = await http.post(url, body: json, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map mapResponse = convert.json.decode(response.body);

      Mercado mercadinho = Mercado.fromJson(mapResponse);

      return ApiResponse.ok(true);
    }
    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }
}
