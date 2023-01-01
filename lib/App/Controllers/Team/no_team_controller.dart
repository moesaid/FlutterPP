import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';

class NoTeamController extends GetxController {
  final _activeIndex = 0.obs;
  int get activeIndex => _activeIndex.value;

  final TeamServices _teamServices = TeamServices();

  HomeController homeController = Get.find();

  Future<void> createTeam(Map<String, dynamic> value) async {
    // name
    // description
    final String name = value['name'];
    final String description = value['description'];

    // create team
    bool isCreated = await Get.showOverlay(
      asyncFunction: () async => await _teamServices.createTeam(
        name: name,
        description: description,
      ),
      loadingWidget: const BuildOverlay(),
    );

    if (isCreated) {
      await homeController.onReady();
    }
  }

  void joinTeam(Map<String, dynamic> value) {
    // code
    final String code = value['code'];

    print({'code': code});
  }
}
