import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class InvoiceProvider {
  final SupabaseClient supabase = Supabase.instance.client;

  // get invoices by team id
  getInvoicesByTeamId() async {
    List<Map> data = await supabase
        .from('invoices')
        .select('*')
        // .eq('team_id', teamId)
        .select();

    print(json.encode(data));

    if (data.isEmpty) return [];

    // List<InvoiceModel> invoices = [];
    // for (var item in data) {
    //   var localJson = json.encode(item);
    //   invoices.add(InvoiceModel.fromJson(json.decode(localJson)));
    // }
    // return invoices;
  }
}
