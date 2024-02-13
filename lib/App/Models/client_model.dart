class ClientModel {
  String? id;
  String? teamId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? contactName;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zip;
  String? logo;
  String? currency, currencySymbol, website, internalNotes;

  ClientModel({
    this.id,
    this.teamId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.contactName,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zip,
    this.logo,
    this.currency,
    this.currencySymbol,
    this.website,
    this.internalNotes,
  });

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    contactName = json['contact_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    logo = json['logo'];
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    website = json['website'];
    internalNotes = json['internal_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['contact_name'] = contactName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip'] = zip;
    data['logo'] = logo;
    data['currency'] = currency;
    data['currency_symbol'] = currencySymbol;
    data['website'] = website;
    data['internal_notes'] = internalNotes;
    return data;
  }

  ClientModel copyWith({
    String? teamId,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zip,
    String? logo,
    String? id,
    String? currency,
    String? currencySymbol,
    String? website,
    String? internalNotes,
  }) {
    return ClientModel(
      teamId: teamId ?? this.teamId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      logo: logo ?? this.logo,
      id: id ?? this.id,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      website: website ?? this.website,
      internalNotes: internalNotes ?? this.internalNotes,
    );
  }
}
