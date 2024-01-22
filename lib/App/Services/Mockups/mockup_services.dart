import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Providers/Network/Mockup/mockup_provider.dart';

class MockupServices {
  MockupProvider mockupProvider = MockupProvider();

  // get all by project ot team id
  Future<List<MockupModel>?> getAllMockups({
    String? projectId,
    String? teamId,
  }) async {
    if (projectId == null && teamId == null) return null;

    if (projectId != null && teamId == null) {
      return await mockupProvider.getByProjectId(projectId: projectId);
    }

    if (projectId == null && teamId != null) {
      return await mockupProvider.getByTeamId(teamId: teamId);
    }

    if (projectId != null && teamId != null) {
      return await mockupProvider.getByTeamAndProjectId(
        teamId: teamId,
        projectId: projectId,
      );
    }
    return null;
  }

  // create mockup
  Future<MockupModel?> createMockup({
    required MockupModel mockup,
  }) async {
    MockupModel? item = await mockupProvider.createMockup(item: mockup);

    // print(item?.toJson());

    return item;
  }
}
