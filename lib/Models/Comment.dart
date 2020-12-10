class Comment {
  String nomeUsuario;
  String comentario;
  String documentId;

  Comment({this.nomeUsuario, this.comentario, this.documentId});

  Comment.fromJson(Map<String, dynamic> json) {
    nomeUsuario = json['nomeUsuario'];
    comentario = json['comentario'];
    documentId = json['documentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeUsuario'] = this.nomeUsuario;
    data['comentario'] = this.comentario;
    data['documentId'] = this.documentId;
    return data;
  }
}
