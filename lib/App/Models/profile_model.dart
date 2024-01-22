class ProfileModel {
  String? id;
  String? updatedAt;
  String? username;
  String? fullName;
  String? avatarUrl;
  String? website;

  ProfileModel({
    this.id,
    this.updatedAt,
    this.username,
    this.fullName,
    this.avatarUrl,
    this.website,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    fullName = json['full_name'];
    avatarUrl = json['avatar_url'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['username'] = username;
    data['full_name'] = fullName;
    data['avatar_url'] = avatarUrl;
    data['website'] = website;
    return data;
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': updatedAt,
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'website': website,
    };
  }

  // copy with
  ProfileModel copyWith({
    String? id,
    String? updatedAt,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? website,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      website: website ?? this.website,
    );
  }
}
