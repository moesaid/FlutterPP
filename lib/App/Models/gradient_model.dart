class GradientModel {
  String? name;
  List<String>? colors;

  GradientModel({this.name, this.colors});

  GradientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    colors = json['colors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['colors'] = colors;
    return data;
  }
}
