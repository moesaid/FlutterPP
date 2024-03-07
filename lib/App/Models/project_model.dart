class ProjectModel {
  String? id;
  String? teamId;
  String? clientId;
  String? createdAt;
  String? title;
  String? description;
  String? status;
  String? dueDate;
  String? budget;
  String? color1;
  String? icon;
  String? color2;
  String? updatedAt;
  String? adminId;
  String? stateManagement;

  ProjectModel({
    this.id,
    this.teamId,
    this.clientId,
    this.createdAt,
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.budget,
    this.color1,
    this.icon,
    this.color2,
    this.updatedAt,
    this.adminId,
    this.stateManagement,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    dueDate = json['due_date'];
    budget = json['budget'];
    color1 = json['color_1'];
    icon = json['icon'];
    color2 = json['color_2'];
    updatedAt = json['updated_at'];
    adminId = json['admin_id'];
    stateManagement = json['state_management'];
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
    data['due_date'] = dueDate;
    data['budget'] = budget;
    data['color_1'] = color1;
    data['icon'] = icon;
    data['color_2'] = color2;
    data['updated_at'] = updatedAt;
    data['admin_id'] = adminId;
    data['state_management'] = stateManagement;
    return data;
  }

  // copy with
  ProjectModel copyWith({
    String? id,
    String? teamId,
    String? clientId,
    String? createdAt,
    String? title,
    String? description,
    String? status,
    String? dueDate,
    String? budget,
    String? color1,
    String? icon,
    String? color2,
    String? updatedAt,
    String? adminId,
    String? stateManagement,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      clientId: clientId ?? this.clientId,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      budget: budget ?? this.budget,
      color1: color1 ?? this.color1,
      icon: icon ?? this.icon,
      color2: color2 ?? this.color2,
      updatedAt: updatedAt ?? this.updatedAt,
      adminId: adminId ?? this.adminId,
      stateManagement: stateManagement ?? this.stateManagement,
    );
  }
}
