class BackgroundTypeModel {
  final String? name, id;
  late bool? isSelected;

  BackgroundTypeModel({
    this.name,
    this.isSelected = false,
    this.id,
  });

  BackgroundTypeModel.fromJson(
    Map<String, dynamic> json,
    this.name,
    this.isSelected,
    this.id,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isSelected'] = isSelected;
    return data;
  }
}
