import 'dart:convert';

import 'package:flutterpp/App/Models/client_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientProvider {
  final supabase = Supabase.instance.client;

  // get clients by team id
  Future<List<ClientModel>?> getClientsByTeamId({
    required String teamId,
  }) async {
    List<Map> data = await supabase
        .from('clients')
        .select('*')
        .eq('team_id', teamId)
        .select();

    if (data.isEmpty) return [];

    List<ClientModel> clients = [];
    for (var item in data) {
      var localJson = json.encode(item);
      clients.add(ClientModel.fromJson(json.decode(localJson)));
    }
    return clients;
  }

  // get client by id
  Future<ClientModel?> getClientById({required String clientId}) async {
    List<Map> data = await supabase
        .from('clients')
        .select('*')
        .eq(
          'id',
          clientId,
        )
        .select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return ClientModel.fromJson(json.decode(localJson));
  }

  // create client
  Future<ClientModel?> createClient({
    required ClientModel client,
  }) async {
    Map<String, dynamic> dataItem =
        client.toJson().map((key, value) => MapEntry(key, value));

    // remove id and created_at
    dataItem.remove('id');
    dataItem.remove('created_at');

    List<Map> data = await supabase.from('clients').insert([dataItem]).select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return ClientModel.fromJson(json.decode(localJson));
  }

  // update client
  Future<ClientModel?> updateClient({
    required ClientModel client,
  }) async {
    if (client.id == null) return null;

    Map dataItem = client.toJson().map((key, value) => MapEntry(key, value));

    // update updated_at
    dataItem['updated_at'] = DateTime.now().toIso8601String();

    // remove where null
    dataItem.removeWhere((key, value) => value == null);

    var data = await supabase
        .from('clients')
        .update(dataItem)
        .eq('id', client.id!)
        .select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return ClientModel.fromJson(json.decode(localJson));
  }

  // delete client
  Future<bool> deleteClient({required String clientId}) async {
    List<Map> data = await supabase
        .from('clients')
        .delete()
        .eq(
          'id',
          clientId,
        )
        .select();

    print(data);

    return data.isNotEmpty;
  }
}
