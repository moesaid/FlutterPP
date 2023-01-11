class WikiModel {
  int? id, projectId;
  String? createdAt, updatedAt, document;

  WikiModel({
    this.id,
    this.document,
    this.createdAt,
    this.updatedAt,
  });

  WikiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    document = json['document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['document'] = document;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
