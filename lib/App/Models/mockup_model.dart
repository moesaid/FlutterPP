class MockupModel {
  String? id;
  String? projectId;
  String? teamId;
  String? title;
  String? description;
  String? category;
  String? icon;
  String? data;
  String? createdAt;
  String? color1;
  String? color2;
  String? templateId;

  MockupModel({
    this.id,
    this.projectId,
    this.teamId,
    this.title,
    this.description,
    this.category,
    this.icon,
    this.data,
    this.createdAt,
    this.color1,
    this.color2,
    this.templateId,
  });

  MockupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    teamId = json['team_id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    icon = json['icon'];
    data = json['data'];
    createdAt = json['created_at'];
    color1 = json['color_1'];
    color2 = json['color_2'];
    templateId = json['template_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['team_id'] = teamId;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['icon'] = icon;
    data['data'] = this.data;
    data['created_at'] = createdAt;
    data['color_1'] = color1;
    data['color_2'] = color2;
    data['template_id'] = templateId;
    return data;
  }

  // to map skip null
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (projectId != null) data['project_id'] = projectId;
    if (teamId != null) data['team_id'] = teamId;
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (category != null) data['category'] = category;
    if (icon != null) data['icon'] = icon;
    // data['data'] = this.data;
    if (createdAt != null) data['created_at'] = createdAt;
    if (color1 != null) data['color_1'] = color1;
    if (color2 != null) data['color_2'] = color2;
    if (templateId != null) data['template_id'] = templateId;
    return data;
  }
}
