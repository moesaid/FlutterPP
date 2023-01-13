import 'package:flutterpp/App/Views/Pages/Project/InnerPages/project_single_board_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/InnerPages/project_single_wiki_page.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class ProjectSingleController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  final _tabs = [
    {
      'icon': HeroIcons.informationCircle,
      'title': 'wiki',
      'page': const ProjectSingleWikiPage(),
      'isActive': true,
    },
    {
      'icon': HeroIcons.clipboardDocumentList,
      'title': 'board',
      'page': const ProjectSingleBoardPage(),
      'isActive': false,
    },
  ].obs;
  List<Map<String, dynamic>> get tabs => _tabs;

  // update tabs
  void updateTabs(int index) {
    for (var el in _tabs) {
      el['isActive'] = false;
    }
    _selectedTab.value = index;
    _tabs[index]['isActive'] = true;
    update();
  }
}
