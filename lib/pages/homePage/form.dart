import 'package:cesta/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Formulario extends StatelessWidget {
  final _produto = TextEditingController();
  final _tcategoria = TextEditingController();
  final _tnomeMercado = TextEditingController();
  final _tpreco = TextEditingController();
  final _tNomeColaborador = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de produtos"),
      ),
      body: _bodyForm(context),
    );
  }

  String _validateProduto(String text) {
    if (text.isEmpty) {
      return "Informe o produto";
    }
    return null;
  }

  String _validatePreco(String text) {
    if (text.isEmpty) {
      return "Informe o preço";
    }
    return null;
  }

  String _validatePCategoria(String text) {
    if (text.isEmpty) {
      return "Informe a categoria";
    }
    return null;
  }

  String _validateMercado(String text) {
    if (text.isEmpty) {
      return "Informe o mercado";
    }
    return null;
  }

  String _validateNome(String text) {
    if (text.isEmpty) {
      return "Informe o nome do colaborador";
    }
    return null;
  }

  _bodyForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _key,
        child: ListView(
          children: <Widget>[
            AppText("Produto", "Informe o produto",
                validator: _validateProduto, controller: _produto),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Preço",
              "Ex: 2.50",
              controller: _tpreco,
              validator: _validatePreco,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Categoria",
              "Ex: Comida",
              controller: _tcategoria,
              validator: _validatePCategoria,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Nome do Mercado",
              "Ex: supermercado db",
              controller: _tnomeMercado,
              validator: _validateMercado,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Nome Colaborador",
              "Ex: José da silva",
              controller: _tNomeColaborador,
              validator: _validateNome,
            ),
            SizedBox(
              height: 20,
            ),
            contButton(context),
          ],
        ),
      ),
    );
  }

  Widget contButton(context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          "Enviar",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        onPressed: () {
          _onClickEnviado(context);
          if(!_key.currentState.validate()){
           return;
          }else{
             Navigator.pop(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          }
          
        },
      ),
    );
  }

  _onClickEnviado(context) {
    if (!_key.currentState.validate()) {
      return;
    }

    final produto = _produto.text;
    final double preco = double.tryParse(_tpreco.text);
    final categoria = _tcategoria.text;
    final nomerMercado = _tnomeMercado.text;
    final colaborador = _tNomeColaborador.text;

    print("produto: $produto  preco:$preco");
  }
}
