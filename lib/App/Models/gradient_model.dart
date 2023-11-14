class GradientModel {
  String? name;
  List<String>? colors;
  double? angle = 0.0;

  GradientModel({
    this.name,
    this.colors,
    this.angle,
  });

  GradientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    colors = json['colors'].cast<String>();
    angle = json['angle'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['colors'] = colors;
    data['angle'] = angle;
    return data;
  }
}
