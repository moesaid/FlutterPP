class PubspecModel {
  String? name;
  String? description;
  String? publishTo;
  String? version;
  Environment? environment;

  PubspecModel({
    this.name,
    this.description,
    this.publishTo,
    this.version,
    this.environment,
  });

  PubspecModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    publishTo = json['publish_to'];
    version = json['version'];
    environment = json['environment'] != null
        ? Environment.fromJson(json['environment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['publish_to'] = publishTo;
    data['version'] = version;
    if (environment != null) {
      data['environment'] = environment!.toJson();
    }
    return data;
  }
}

class Environment {
  String? sdk;

  Environment({this.sdk});

  Environment.fromJson(Map<String, dynamic> json) {
    sdk = json['sdk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sdk'] = sdk;
    return data;
  }
}
