class ProjectLocalPathModel {
  String? id, path;

  ProjectLocalPathModel({this.id, this.path});

  ProjectLocalPathModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    return data;
  }

  ProjectLocalPathModel copyWith({
    String? id,
    String? path,
  }) {
    return ProjectLocalPathModel(
      id: id ?? this.id,
      path: path ?? this.path,
    );
  }
}
