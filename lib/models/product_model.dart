class ProductModel {
  Response response;

  ProductModel({this.response});

  ProductModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  String status;
  List<Messages> messages;
  List<Produtos> produtos;

  Response({this.status, this.messages, this.produtos});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
    if (json['produtos'] != null) {
      produtos = new List<Produtos>();
      json['produtos'].forEach((v) {
        produtos.add(new Produtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String message;

  Messages({this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class Produtos {
  int codigo;
  String codigoBarras;
  String descricao;
  double preco;
  Produtos({
    this.codigo,
    this.codigoBarras,
    this.descricao,
    this.preco,
  });

  Produtos.fromJson(Map<String, dynamic> json) {
    codigo = json['Codigo'];
    codigoBarras = json['CodigoBarras'];
    descricao = json['Descricao'];
    preco = json['Preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Codigo'] = this.codigo;
    data['CodigoBarras'] = this.codigoBarras;
    data['Descricao'] = this.descricao;
    data['Preco'] = this.preco;
    return data;
  }
}
