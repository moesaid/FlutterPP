class InvoiceModel {
  String? id;
  String? teamId;
  String? clientId, clientName, currency;
  int? number;
  String? dueDate;
  String? status;
  int? discount;
  int? tax;
  List<InvoiceItem>? items;
  String? createdAt, updatedAt;

  InvoiceModel({
    this.id,
    this.teamId,
    this.clientId,
    this.clientName,
    this.currency,
    this.number,
    this.dueDate,
    this.status,
    this.discount,
    this.tax,
    this.items,
    this.createdAt,
    this.updatedAt,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    currency = json['currency'];
    number = json['number'];
    dueDate = json['due_date'];
    status = json['status'];
    discount = json['discount'];
    tax = json['tax'];
    if (json['items'] != null) {
      items = <InvoiceItem>[];
      json['items'].forEach((v) {
        items!.add(InvoiceItem.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['client_id'] = clientId;
    data['client_name'] = clientName;
    data['currency'] = currency;
    data['number'] = number;
    data['due_date'] = dueDate;
    data['status'] = status;
    data['discount'] = discount;
    data['tax'] = tax;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // copy with new values
  InvoiceModel copyWith({
    String? id,
    String? teamId,
    String? clientId,
    String? clientName,
    String? currency,
    int? number,
    String? dueDate,
    String? status,
    int? discount,
    int? tax,
    List<InvoiceItem>? items,
    String? createdAt,
    String? updatedAt,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      currency: currency ?? this.currency,
      number: number ?? this.number,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class InvoiceItem {
  int? price;
  String? title;
  int? quantity;

  InvoiceItem({this.price, this.title, this.quantity});

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    title = json['title'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['title'] = title;
    data['quantity'] = quantity;
    return data;
  }

  // copy with new values
  InvoiceItem copyWith({
    int? price,
    String? title,
    int? quantity,
  }) {
    return InvoiceItem(
      price: price ?? this.price,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }
}
