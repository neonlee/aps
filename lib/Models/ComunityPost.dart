class ComunityPost {
  String uid;
  String title;
  String description;

  ComunityPost({this.title, this.description, this.uid});

  ComunityPost.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['uid'] = this.uid;
    return data;
  }
}
