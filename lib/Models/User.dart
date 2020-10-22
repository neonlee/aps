class Users {
  String email;
  String name;
  String password;
  String year;
  String user;

  Users({this.email, this.name, this.password, this.year, this.user});

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    year = json['year'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['year'] = this.year;
    data['user'] = this.user;
    return data;
  }
}
