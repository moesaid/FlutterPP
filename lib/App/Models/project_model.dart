class ProjectModel {
  String? id;
  String? teamId;
  String? clientId;
  String? createdAt;
  String? title;
  String? description;
  String? status;
  String? startDate;
  String? endDate;
  String? budget;
  String? color1;
  String? icon;
  String? color2;
  String? updatedAt;
  String? adminId;

  ProjectModel(
      {this.id,
      this.teamId,
      this.clientId,
      this.createdAt,
      this.title,
      this.description,
      this.status,
      this.startDate,
      this.endDate,
      this.budget,
      this.color1,
      this.icon,
      this.color2,
      this.updatedAt,
      this.adminId});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    budget = json['budget'];
    color1 = json['color_1'];
    icon = json['icon'];
    color2 = json['color_2'];
    updatedAt = json['updated_at'];
    adminId = json['admin_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['client_id'] = clientId;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['budget'] = budget;
    data['color_1'] = color1;
    data['icon'] = icon;
    data['color_2'] = color2;
    data['updated_at'] = updatedAt;
    data['admin_id'] = adminId;
    return data;
  }
}
