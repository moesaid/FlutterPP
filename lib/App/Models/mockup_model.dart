import 'package:flutterpp/App/Models/template_config_model.dart';

class MockupModel {
  String? id;
  String? projectId;
  String? teamId;
  String? title;
  String? description;
  String? category;
  String? icon;
  List<TemplateConfigModel>? jsonData;
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
    this.jsonData,
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
    // jsonData = json['json_data'] != null
    //     ? TemplateConfigModel.fromJson(json['json_data'])
    //     : null;

    if (json['json_data'] != null) {
      jsonData = <TemplateConfigModel>[];
      json['json_data'].forEach((v) {
        jsonData!.add(TemplateConfigModel.fromJson(v));
      });
    }
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
    // if (jsonData != null) {
    //   data['json_data'] = jsonData!.toJson();
    // }

    if (jsonData != null) {
      data['json_data'] = jsonData!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['color_1'] = color1;
    data['color_2'] = color2;
    data['template_id'] = templateId;
    return data;
  }

  // to map skip null
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (teamId != null) 'team_id': teamId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (color1 != null) 'color_1': color1,
      if (color2 != null) 'color_2': color2,
      if (templateId != null) 'template_id': templateId,
      // if (jsonData != null) 'json_data': jsonData!.toJson(),
      if (jsonData != null)
        'json_data': jsonData!.map((v) => v.toJson()).toList(),
    };
  }
}
