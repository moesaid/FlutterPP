class BoardModel {
  int? id, index, projectId;
  String? name, createdAt, updatedAt;

  BoardModel({
    this.id,
    this.projectId,
    this.name,
    this.index,
    this.createdAt,
    this.updatedAt,
  });

  BoardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    index = json['index'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['index'] = index;
    data['project_id'] = projectId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project_id': projectId,
      'name': name,
      'index': index,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
