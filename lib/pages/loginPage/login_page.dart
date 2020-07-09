import 'dart:async';

import 'package:cesta/blocs/login_bloc.dart';
import 'package:cesta/model/usuario.dart';
import 'package:cesta/pages/homePage/home_page.dart';
import 'package:cesta/utils/nav.dart';
import 'package:cesta/widgets/app_button.dart';
import 'package:cesta/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'alerta.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _streamController = StreamController<bool>();
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bloc = LoginBloc();
  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if (user != null) {
        rotas(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fazer Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _body(context),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Informe Login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            AppText(
              "Senha",
              "Informe a senha",
              controller: _tSenha,
              validator: _validateSenha,
              password: true,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data != null ? snapshot.data: false,
                  );
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final login = _tLogin.text;
    final senha = _tSenha.text;

    _streamController.sink.add(true);

    var usuario = await bloc.login(login, senha);

    if (usuario != null) {
      rotas(context, HomePage());
    } else {
      alert(context, "Login Inválido");
    }
    _streamController.sink.add(false);

    /* if (login.isEmpty || senha.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text("Login e/ ou senha inválidos"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {},
                              )
                            ],
                          );
                        });
                  }
                }*/
  }
  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
