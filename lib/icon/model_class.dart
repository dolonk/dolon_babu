class IconModel {
  int? id;
  String? icon;
  String? email;
  String? categoryName;

  IconModel({this.id, this.icon, this.email, this.categoryName});

  IconModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'] != null ? "https://grozziie.zjweiting.com:8033/tht/images/${json['icon']}" : "assets/images/default_icon.png";
    email = json['email'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['email'] = this.email;
    data['categoryName'] = this.categoryName;
    return data;
  }
}


