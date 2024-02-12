import 'dart:convert';

import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InvoiceProvider {
  final SupabaseClient supabase = Supabase.instance.client;

  // get invoices by team id
  Future<List<InvoiceModel>?> getInvoicesByTeamId({
    required String teamId,
  }) async {
    List<Map> data = await supabase
        .from('invoices')
        .select('*')
        .eq('team_id', teamId)
        .select();

    if (data.isEmpty) return [];

    List<InvoiceModel> invoices = [];
    for (var item in data) {
      var localJson = json.encode(item);
      invoices.add(InvoiceModel.fromJson(json.decode(localJson)));
    }
    return invoices;
  }

  // get invoice by id
  Future<InvoiceModel?> getInvoiceById({required String invoiceId}) async {
    List<Map> data = await supabase
        .from('invoices')
        .select('*')
        .eq('id', invoiceId)
        .select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return InvoiceModel.fromJson(json.decode(localJson));
  }

  // create invoice
  Future<InvoiceModel?> createInvoice({
    required InvoiceModel invoice,
  }) async {
    Map<String, dynamic> dataItem = invoice.toJson().map(
          (key, value) => MapEntry(key, value),
        );

    // remove id and created_at
    dataItem.remove('id');
    dataItem.remove('created_at');

    List<Map> data =
        await supabase.from('invoices').insert([dataItem]).select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return InvoiceModel.fromJson(json.decode(localJson));
  }

  // update invoice
  Future<InvoiceModel?> updateInvoice({
    required InvoiceModel invoice,
  }) async {
    if (invoice.id == null) return null;

    Map<String, dynamic> dataItem = invoice.toJson().map(
          (key, value) => MapEntry(key, value),
        );

    // remove created_at
    dataItem.remove('created_at');

    List<Map> data = await supabase
        .from('invoices')
        .update(dataItem)
        .eq('id', invoice.id!)
        .select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return InvoiceModel.fromJson(json.decode(localJson));
  }

  // delete invoice
  Future<bool> deleteInvoice({required String invoiceId}) async {
    List<Map> data =
        await supabase.from('invoices').delete().eq('id', invoiceId).select();

    return data.isNotEmpty;
  }
}
