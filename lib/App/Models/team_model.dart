class TeamModel {
  String? id;
  String? adminId;
  String? name;
  String? avatarUrl;
  String? updatedAt;
  String? createdAt;
  String? description;

  TeamModel({
    this.id,
    this.adminId,
    this.name,
    this.avatarUrl,
    this.updatedAt,
    this.createdAt,
    this.description,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['admin_id'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admin_id'] = adminId;
    data['name'] = name;
    data['avatar_url'] = avatarUrl;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['description'] = description;
    return data;
  }
}
