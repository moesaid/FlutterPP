class TeamModel {
  String? id;
  String? adminId;
  String? name;
  String? avatarUrl;
  String? description;
  String? ownerName, address, city, state, country, phone, email;
  int? zip;
  String? updatedAt;
  String? createdAt;

  TeamModel({
    this.id,
    this.adminId,
    this.name,
    this.avatarUrl,
    this.description,
    this.ownerName,
    this.address,
    this.city,
    this.state,
    this.country,
    this.phone,
    this.email,
    this.zip,
    this.updatedAt,
    this.createdAt,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['admin_id'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    description = json['description'];
    ownerName = json['owner_name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    zip = json['zip'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admin_id'] = adminId;
    data['name'] = name;
    data['avatar_url'] = avatarUrl;
    data['description'] = description;
    data['owner_name'] = ownerName;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['phone'] = phone;
    data['email'] = email;
    data['zip'] = zip;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }

  TeamModel copyWith({
    String? id,
    String? adminId,
    String? name,
    String? avatarUrl,
    String? description,
    String? ownerName,
    String? address,
    String? city,
    String? state,
    String? country,
    String? phone,
    String? email,
    int? zip,
    String? updatedAt,
    String? createdAt,
  }) {
    return TeamModel(
      id: id ?? this.id,
      adminId: adminId ?? this.adminId,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
      ownerName: ownerName ?? this.ownerName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      zip: zip ?? this.zip,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
