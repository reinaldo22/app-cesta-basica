import 'package:cesta/blocs/mercado_bloc.dart';
import 'package:cesta/model/mercado.dart';
import 'package:cesta/pages/homePage/form.dart';
import 'package:cesta/widgets/text.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Mercado produtos;

  final _bloc = MercadoBloc();

  @override
  void initState() {
    super.initState();

    _bloc.carregaProdutos();
  }

//fecha o streambuilder
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos Cadastrados"),
        centerTitle: true,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Formulario()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      drawer: DrawerList(),
    );
  }

  _body() {
    return StreamBuilder(
        stream: _bloc.mercadosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erro ao acessar os dados");
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Mercado> produtos = snapshot.data;

          return _listaTudo(produtos);
        });
  }

  _listaTudo(produtos) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: produtos != null ? produtos.length : 0,
          itemBuilder: (context, index) {
            Mercado m = produtos[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text("Mercado: " + m.nomeMercado, fontSize: 20),
                    text("Produto: " + m.produto, fontSize: 20),
                    text("Colaborador: " + m.colaborador, fontSize: 20),
                    text("Preço: " + m.preco.toString(), fontSize: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    return _bloc.carregaProdutos();
  }
}
