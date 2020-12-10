class ComunityPost {
  String uid;
  String title;
  String description;
  int like;

  ComunityPost({this.title, this.description, this.uid, this.like});

  ComunityPost.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    uid = json['uid'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['uid'] = this.uid;
    data['like'] = this.like;
    return data;
  }
}
