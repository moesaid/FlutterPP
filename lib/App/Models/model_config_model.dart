class ModelConfigModel {
  String? modelName;
  List<String>? additionals;
  String? style;
  List<Relations>? relations;
  List<Properties>? properties;

  ModelConfigModel(
      {this.modelName,
      this.additionals,
      this.style,
      this.relations,
      this.properties});

  ModelConfigModel.fromJson(Map<String, dynamic> json) {
    modelName = json['model_name'];
    if (json['additionals'] != null) {
      additionals = <String>[];
      json['additionals'].forEach((v) {
        additionals!.add(v);
      });
    }

    style = json['style'];
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
    data['model_name'] = modelName;
    data['style'] = style;

    if (additionals != null) {
      data['additionals'] = additionals;
    }

    if (relations != null) {
      data['relations'] = relations!.map((v) => v.toJson()).toList();
    }
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    return data;
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
    data['type'] = type;

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
  dynamic,
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
      case PropertieType.dynamic:
        return 'dynamic';
      case PropertieType.hasOne:
        return 'hasOne';
      case PropertieType.hasMany:
        return 'hasMany';
    }
  }

  // return enum from string
  static PropertieType? fromString(String? type) {
    switch (type) {
      case 'String':
        return PropertieType.string;
      case 'int':
        return PropertieType.int;
      case 'double':
        return PropertieType.double;
      case 'bool':
        return PropertieType.bool;
      case 'List':
        return PropertieType.list;
      case 'List<String>':
        return PropertieType.listOfString;
      case 'List<int>':
        return PropertieType.listOfInt;
      case 'List<double>':
        return PropertieType.listOfDouble;
      case 'List<bool>':
        return PropertieType.listOfBool;
      case 'Map':
        return PropertieType.map;
      case 'dynamic':
        return PropertieType.dynamic;
      case 'hasOne':
        return PropertieType.hasOne;
      case 'hasMany':
        return PropertieType.hasMany;
    }
    return null;
  }
}
