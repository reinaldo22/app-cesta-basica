import 'package:cesta/api_response.dart';
import 'package:cesta/database/mercado_api.dart';
import 'package:cesta/model/mercado.dart';
import 'package:cesta/pages/loginPage/alerta.dart';
import 'package:cesta/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Formulario extends StatefulWidget {
  final Mercado mercado;

  Formulario({this.mercado});

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  var testecontroller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  final _produto = TextEditingController();
  final _tcategoria = TextEditingController();
  final _tnomeMercado = TextEditingController();
  //final _tpreco = TextEditingController();
  final _tNomeColaborador = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  var _showProgress = false;

  Mercado get mercado => widget.mercado;

  @override
  void initState() {
    super.initState();
    if (mercado != null) {
      _produto.text = mercado.produto;
      _tcategoria.text = mercado.categoria;
      _tnomeMercado.text = mercado.nomeMercado;
      double preco = double.tryParse(testecontroller.text);
      _tNomeColaborador.text = mercado.nomeMercado;
    }
  }

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
              controller: testecontroller,
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
        },
      ),
    );
  }

  _onClickEnviado(context) async {
    if (!_key.currentState.validate()) {
      return;
    }

    // Cria os dados
    var c = mercado ?? Mercado();
    c.categoria = _tcategoria.text;
    c.colaborador = _tNomeColaborador.text;
    c.produto = _produto.text;
    c.preco = double.tryParse(testecontroller.text);
    c.nomeMercado = _tnomeMercado.text;

    print("Mercado: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");

    ApiResponse<bool> response = await MercadoApi.saveMercado(c);
    if (response.ok) {
      alert(context, "Dados salvos com sucesso", callback: () {
        Navigator.pop(context);
      });
    } else {
      alert(context, response.msg);
    }
    setState(() {
      _showProgress = false;
    });
    print("Fim.");
  }
}
