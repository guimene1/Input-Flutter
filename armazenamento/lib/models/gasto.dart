class Gasto {
  final int? id;
  final double valor;
  final String descricao;
  final String moeda;
  final String simbolo;

  Gasto({
    this.id,
    required this.valor,
    required this.descricao,
    required this.moeda,
    required this.simbolo,
  });
  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'valor':valor,
      'descricao':descricao,
      'moeda':moeda,
      'simbolo':simbolo,
    };
  }
}
