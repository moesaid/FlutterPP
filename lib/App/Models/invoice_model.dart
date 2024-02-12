class InvoiceModel {
  String? id;
  String? teamId;
  String? clientId;
  int? number;
  String? dueDate;
  String? status;
  int? discount;
  int? tax;
  List<InvoiceItems>? items;
  String? createdAt;

  InvoiceModel({
    this.id,
    this.teamId,
    this.clientId,
    this.number,
    this.dueDate,
    this.status,
    this.discount,
    this.tax,
    this.items,
    this.createdAt,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    clientId = json['client_id'];
    number = json['number'];
    dueDate = json['due_date'];
    status = json['status'];
    discount = json['discount'];
    tax = json['tax'];
    if (json['items'] != null) {
      items = <InvoiceItems>[];
      json['items'].forEach((v) {
        items!.add(InvoiceItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['client_id'] = clientId;
    data['number'] = number;
    data['due_date'] = dueDate;
    data['status'] = status;
    data['discount'] = discount;
    data['tax'] = tax;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class InvoiceItems {
  int? price;
  String? title;
  int? quantity;

  InvoiceItems({this.price, this.title, this.quantity});

  InvoiceItems.fromJson(Map<String, dynamic> json) {
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
}
