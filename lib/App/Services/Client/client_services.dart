import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Providers/Network/Client/client_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';

class ClientServices {
  final ClientProvider _provider = ClientProvider();
  final TeamServices _teamServices = TeamServices();
  final CallPipeline _callPipeline = CallPipeline();

  // get clients by team id
  Future<List<ClientModel>?> getClientsByTeamId() async {
    // get team
    final TeamModel? team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return _callPipeline.futurePipeline(
      future: () => _provider.getClientsByTeamId(teamId: team.id!),
      name: 'getClientsByTeamId',
    );
  }

  // get client by id
  Future<ClientModel?> getClientById({required String clientId}) async {
    return _callPipeline.futurePipeline(
      future: () => _provider.getClientById(clientId: clientId),
      name: 'getClientById',
    );
  }

  // create client
  Future<ClientModel?> createClient({
    required ClientModel client,
  }) async {
    // get team
    final TeamModel? team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return _callPipeline.futurePipeline(
      future: () => _provider.createClient(
        client: client.copyWith(teamId: team.id!),
      ),
      name: 'createClient',
    );
  }

  // update client
  Future<ClientModel?> updateClient({
    required ClientModel client,
  }) async {
    return _callPipeline.futurePipeline(
      future: () => _provider.updateClient(client: client),
      name: 'updateClient',
    );
  }

  // delete client
  Future<bool> deleteClient({required String clientId}) async {
    bool? data = await _callPipeline.futurePipeline(
      future: () => _provider.deleteClient(clientId: clientId),
      name: 'deleteClient',
    );

    return data ?? false;
  }
}
