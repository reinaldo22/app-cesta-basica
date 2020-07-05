import 'dart:convert' as convert;

class Mercado {
  int id;
  String produto;
  double preco;
  String colaborador;
  String nomeMercado;
  String categoria;

  Mercado(
      {this.id, this.produto, this.preco, this.colaborador, this.nomeMercado, this.categoria});

  //transforma de json para objeto
  Mercado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produto = json['produto'];
    preco = json['preco'];
    colaborador = json['colaborador'];
    nomeMercado = json['nomeMercado'];
    categoria = json['categoria'];
  }
  //transforma de objeto para json
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produto'] = this.produto;
    data['preco'] = this.preco;
    data['colaborador'] = this.colaborador;
    data['nomeMercado'] = this.nomeMercado;
    data['categoria'] = this.categoria;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Mercado{id: $id, produto: $produto, preco: $preco, colaborador: $colaborador, nomeMercado: $nomeMercado, categoria: $categoria}';
  }
}
