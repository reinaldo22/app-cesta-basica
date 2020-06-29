import 'package:cesta/utils/prefs.dart';
import 'dart:convert' as convert;

class Usuario {
  String login;
  String email;
  String token;
  List<String> roles;

  Usuario({this.login, this.email, this.token, this.roles});

  //transforma de json para objeto
  Usuario.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    email = json['email'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

//transforma de objeto para json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['email'] = this.email;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

static void clear() {
    Prefs.setString("user.prefs", "");
  }
  //salva o usuario
  void save() {
     Map map = toJson(); // json e passa para o map

    String json = convert.json.encode(map);// pega o map e passa para string

    Prefs.setString("user.prefs", json);
  }
  //lê o usuário
  static Future<Usuario> get() async{
    String json =  await Prefs.getString("user.prefs");
    if(json.isEmpty){
      return null;
    }
    Map map = convert.json.decode(json);
    Usuario user = Usuario.fromJson(map);
    return user;
  }
  @override
  String toString() {
   

    return 'Usuario{login: $login, nome: $token, email:$email}';
  }

  
}