class Finance {
  String description;
  String type;
  String name;
  String value;
  String date;

  Finance({this.description, this.type, this.name, this.value, this.date});

  Finance.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    type = json['type'];
    name = json['name'];
    value = json['value'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['type'] = this.type;
    data['name'] = this.name;
    data['value'] = this.value;
    data['date'] = this.date;
    return data;
  }
}
