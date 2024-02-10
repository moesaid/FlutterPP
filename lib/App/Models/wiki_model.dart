class WikiModel {
  String? projectId, id, title, icon, createdAt, updatedAt;
  Map<String, dynamic>? document;

  WikiModel({
    this.id,
    this.projectId,
    this.title,
    this.icon,
    this.document,
    this.createdAt,
    this.updatedAt,
  });

  WikiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    title = json['title'];
    icon = json['icon'];
    document = json['document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['title'] = title;
    data['icon'] = icon;
    data['document'] = document;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  WikiModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? icon,
    Map<String, dynamic>? document,
    String? createdAt,
    String? updatedAt,
  }) {
    return WikiModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      document: document ?? this.document,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
