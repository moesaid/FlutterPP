class MediaModel {
  String? id;
  String? teamId;
  String? mockupId;
  String? bucketId;
  String? path;
  String? publicUrl;
  int? size;
  String? createdAt;
  String? fileName, type;

  MediaModel({
    this.id,
    this.teamId,
    this.mockupId,
    this.bucketId,
    this.path,
    this.publicUrl,
    this.size,
    this.createdAt,
    this.fileName,
    this.type,
  });

  MediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    mockupId = json['mockup_id'];
    bucketId = json['bucket_id'];
    path = json['path'];
    publicUrl = json['public_url'];
    size = json['size'];
    createdAt = json['created_at'];
    fileName = json['file_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['mockup_id'] = mockupId;
    data['bucket_id'] = bucketId;
    data['path'] = path;
    data['public_url'] = publicUrl;
    data['size'] = size;
    data['created_at'] = createdAt;
    data['file_name'] = fileName;
    data['type'] = type;
    return data;
  }
}
