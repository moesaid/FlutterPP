class CheckEnvModel {
  bool? dartInstalled;
  bool? flutterInstalled;
  String? flutterVersion;
  String? dartVersion;
  List<FlutterDoctor>? flutterDoctor;

  CheckEnvModel(
      {this.dartInstalled,
      this.flutterInstalled,
      this.flutterVersion,
      this.dartVersion,
      this.flutterDoctor});

  CheckEnvModel.fromJson(Map<String, dynamic> json) {
    dartInstalled = json['dart_installed'];
    flutterInstalled = json['flutter_installed'];
    flutterVersion = json['flutter_version'];
    dartVersion = json['dart_version'];
    if (json['flutter_doctor'] != null) {
      flutterDoctor = <FlutterDoctor>[];
      json['flutter_doctor'].forEach((v) {
        flutterDoctor!.add(FlutterDoctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dart_installed'] = dartInstalled;
    data['flutter_installed'] = flutterInstalled;
    data['flutter_version'] = flutterVersion;
    data['dart_version'] = dartVersion;
    if (flutterDoctor != null && flutterDoctor!.isNotEmpty) {
      data['flutter_doctor'] = flutterDoctor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlutterDoctor {
  bool? head;
  String? body;

  FlutterDoctor({this.head, this.body});

  FlutterDoctor.fromJson(Map<String, dynamic> json) {
    head = json['head'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['head'] = head;
    data['body'] = body;
    return data;
  }
}
