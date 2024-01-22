import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Mockups/mockup_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:get/get.dart';

class MockupIndexController extends GetxController {
  final TeamServices _teamServices = TeamServices();
  final MockupServices _mockupServices = MockupServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _hoveredId = ''.obs;
  String get hoveredId => _hoveredId.value;

  final _items = <MockupModel>[].obs;
  List<MockupModel> get items => _items;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  @override
  Future<void> onInit() async {
    await fetchApi();
    _updateLoading(false);
    super.onInit();
  }

  Future<void> fetchApi() async {
    _team.value = (await _teamServices.getTeamForAuthUser())!;

    if (_team.value.id == null) return;

    List<MockupModel>? mockups = await _mockupServices.getAllMockups(
      teamId: _team.value.id,
    );

    if (mockups == null || mockups.isEmpty) return;
    items.assignAll(mockups);
    update();
  }

  void _updateLoading(bool bool) {
    _isLoading.value = bool;
    update();
  }

  // hover
  void onHover(bool isHovring, String id) {
    if (isHovring) {
      _hoveredId.value = id;
    } else {
      _hoveredId.value = '';
    }

    update();
  }
}
