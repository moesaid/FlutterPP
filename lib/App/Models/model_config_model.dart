import 'package:flutter/material.dart';

class ModelConfigModel {
  String? id, projectId, modelName, color;
  bool? isCrud;

  List<Relations>? relations;
  List<Properties>? properties;

  ModelConfigModel({
    this.id,
    this.projectId,
    this.modelName,
    this.color,
    this.isCrud,
    this.relations,
    this.properties,
  });

  ModelConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    modelName = json['model_name'];
    color = json['color'];
    isCrud = json['is_crud'];

    if (json['relations'] != null) {
      relations = <Relations>[];
      json['relations'].forEach((v) {
        relations!.add(Relations.fromJson(v));
      });
    }
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['model_name'] = modelName;
    data['color'] = color;
    data['is_crud'] = isCrud;

    if (relations != null) {
      data['relations'] = relations!.map((v) => v.toJson()).toList();
    }
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // copy with new values
  ModelConfigModel copyWith({
    String? id,
    String? projectId,
    String? modelName,
    String? color,
    bool? isCrud,
    List<Relations>? relations,
    List<Properties>? properties,
  }) {
    return ModelConfigModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      modelName: modelName ?? this.modelName,
      color: color ?? this.color,
      isCrud: isCrud ?? this.isCrud,
      relations: relations ?? this.relations,
      properties: properties ?? this.properties,
    );
  }
}

class Relations {
  String? name;

  Relations({this.name});

  Relations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Properties {
  String? name, relationName;
  PropertieType? type;

  Properties({this.name, this.type, this.relationName});

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relationName = json['relation_name'];
    type = PropertieType.fromString(json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['relation_name'] = relationName;
    data['type'] = type.toString().split('.').last;

    return data;
  }
}

enum PropertieType {
  string,
  int,
  double,
  bool,
  listOfString,
  listOfInt,
  listOfDouble,
  listOfBool,
  list,
  map,
  hasOne,
  hasMany;

  // return string value of enum
  String get type {
    switch (this) {
      case PropertieType.string:
        return 'String';
      case PropertieType.int:
        return 'int';
      case PropertieType.double:
        return 'double';
      case PropertieType.bool:
        return 'bool';
      case PropertieType.list:
        return 'List';
      case PropertieType.listOfString:
        return 'List<String>';
      case PropertieType.listOfInt:
        return 'List<int>';
      case PropertieType.listOfDouble:
        return 'List<double>';
      case PropertieType.listOfBool:
        return 'List<bool>';
      case PropertieType.map:
        return 'Map';
      case PropertieType.hasOne:
        return 'hasOne';
      case PropertieType.hasMany:
        return 'hasMany';
    }
  }

  // return enum from string
  static PropertieType? fromString(String? type) {
    switch (type) {
      case 'string':
        return PropertieType.string;
      case 'int':
        return PropertieType.int;
      case 'double':
        return PropertieType.double;
      case 'bool':
        return PropertieType.bool;
      case 'list':
        return PropertieType.list;
      case 'listOfString':
        return PropertieType.listOfString;
      case 'listOfInt':
        return PropertieType.listOfInt;
      case 'listOfDouble':
        return PropertieType.listOfDouble;
      case 'listOfBool':
        return PropertieType.listOfBool;
      case 'map':
        return PropertieType.map;
      case 'hasOne':
        return PropertieType.hasOne;
      case 'hasMany':
        return PropertieType.hasMany;
    }
    return null;
  }

  // color for each type
  Color get color {
    switch (this) {
      case PropertieType.string:
        return Colors.blue;
      case PropertieType.int:
        return Colors.green;
      case PropertieType.double:
        return Colors.cyan;
      case PropertieType.bool:
        return Colors.red;
      case PropertieType.list:
        return Colors.orange;
      case PropertieType.listOfString:
        return Colors.orange;
      case PropertieType.listOfInt:
        return Colors.orange;
      case PropertieType.listOfDouble:
        return Colors.orange;
      case PropertieType.listOfBool:
        return Colors.orange;
      case PropertieType.map:
        return Colors.yellow;

      case PropertieType.hasOne:
        return Colors.purple;
      case PropertieType.hasMany:
        return Colors.pink;
    }
  }

  // list of names
  static List<String> get names {
    return PropertieType.values
        .map((e) => e.toString().split('.').last)
        .toList();
  }
}
