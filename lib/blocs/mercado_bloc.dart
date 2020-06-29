import 'dart:async';
import 'package:cesta/database/mercado_api.dart';
import 'package:cesta/model/mercado.dart';

class MercadoBloc {
  final _streamController = StreamController<List<Mercado>>();

  get mercadosStream => _streamController.stream;

 Future<List<Mercado>> carregaProdutos() async {
    List<Mercado> produtos = await MercadoApi.getMercado();

    _streamController.add(produtos);

    return produtos;
  }

  void dispose() {
    _streamController.close();
  }
}
