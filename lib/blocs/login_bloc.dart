
import 'package:cesta/database/login_api.dart';
import 'package:cesta/model/usuario.dart';

class LoginBloc {
  Future<Usuario> login(String login, String senha) async {
    var usuario = await LoginApi.login(login, senha);

    return usuario;
  }
}
