import 'package:flutter/material.dart';

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
    return Form(
      key: _key,
      child: ListView(
        children: <Widget>[
          textFormProduto(),
          textFormpreco(),
          textFormcategoria(),
          textFormNomeMercado(),
          textFormNomeColaborador(),
          contButton(context),
        ],
      ),
    );
  }

  TextFormField textFormProduto() {
    return TextFormField(
      controller: _produto,
      validator: _validateProduto,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: "Produto",
          labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          hintText: "Informe o produto"),
    );
  }

  TextFormField textFormpreco() {
    return TextFormField(
      controller: _tpreco,
       validator: _validatePreco,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: "Preço",
          labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          hintText: "2.50"),
    );
  }

  TextFormField textFormcategoria() {
    return TextFormField(
      controller: _tcategoria,
      validator: _validatePCategoria,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: "Categoria",
          labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          hintText: "categoria..."),
    );
  }

  TextFormField textFormNomeMercado() {
    return TextFormField(
      controller: _tnomeMercado,
      validator: _validateMercado,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: "Nome do supermercado",
          labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          hintText: "EX: Supermercado Db"),
    );
  }

  TextFormField textFormNomeColaborador() {
    return TextFormField(
      controller: _tNomeColaborador,
      validator: _validateNome,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: "Nome Colaborador",
          labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          hintText: "EX: José da silva"),
    );
  }

  contButton(context) {
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
        },
      ),
    );
  }

   _onClickEnviado(context) {
     if(!_key.currentState.validate()) {
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
