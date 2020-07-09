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
      color: Colors.lightBlueAccent,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: produtos != null ? produtos.length : 0,
          itemBuilder: (context, index) {
            Mercado m = produtos[index];

            return Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 5.0,
                          left: 5.0,
                          right: 20.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.restaurant,
                              color: Colors.amber,
                              size: 40.0,
                            ),
                            text(m.produto,
                                fontSize: 25.0, color: Colors.black),
                            Spacer(),
                            text('R\$' + m.preco.toString(), fontSize: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.shopping_basket,
                              color: Colors.redAccent,
                              size: 25.0,
                            ),
                            text(
                              m.nomeMercado,
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 25.0,
                            ),
                            text(m.colaborador, fontSize: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
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

  //fecha o streambuilder
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
