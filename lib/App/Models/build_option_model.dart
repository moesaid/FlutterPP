class BuildOptionModel {
  bool? models;
  bool? pages;
  bool? routes;
  bool? controllers;
  bool? bindings;
  bool? services;
  bool? providers;
  bool? blocs;
  bool? cubits;

  BuildOptionModel({
    this.models,
    this.pages,
    this.routes,
    this.controllers,
    this.bindings,
    this.services,
    this.providers,
    this.blocs,
    this.cubits,
  });

  BuildOptionModel.fromJson(Map<String, dynamic> json) {
    models = json['models'];
    pages = json['pages'];
    routes = json['routes'];
    controllers = json['controllers'];
    bindings = json['bindings'];
    services = json['services'];
    providers = json['providers'];
    blocs = json['blocs'];
    cubits = json['cubits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['models'] = models;
    data['pages'] = pages;
    data['routes'] = routes;
    data['controllers'] = controllers;
    data['bindings'] = bindings;
    data['services'] = services;
    data['providers'] = providers;
    data['blocs'] = blocs;
    data['cubits'] = cubits;
    return data;
  }
}
