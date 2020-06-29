class Mercado {
  int id;
  String produto;
  double preco;
  String colaborador;
  String nomeMercado;

  Mercado(
      {this.id, this.produto, this.preco, this.colaborador, this.nomeMercado});

  //transforma de json para objeto
  Mercado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produto = json['produto'];
    preco = json['preco'];
    colaborador = json['colaborador'];
    nomeMercado = json['nomeMercado'];
  }
  //transforma de objeto para json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produto'] = this.produto;
    data['preco'] = this.preco;
    data['colaborador'] = this.colaborador;
    data['nomeMercado'] = this.nomeMercado;
    return data;
  }
}