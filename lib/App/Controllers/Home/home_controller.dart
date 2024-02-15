import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Pages/Client/client_index_page.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/dashboard_page.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/invoice_index_page.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/mockup_index_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/Pages/project_single_page.dart';
import 'package:flutterpp/Storage/active_project_storage.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class HomeController extends GetxController {
  final AuthServices _authServices = AuthServices();
  final TeamServices _teamServices = TeamServices();

  final _tabs = [
    {
      'title': 'dashboard',
      'icon': HeroIcons.home,
      'isActive': true,
      'tab': const DashboardPage(),
    },
    {
      'title': 'projects',
      'icon': HeroIcons.squaresPlus,
      'isActive': false,
      'tab': const ProjectSinglePage(),
      'type': 'project',
    },
    {
      'title': 'clients',
      'icon': HeroIcons.users,
      'isActive': false,
      'tab': const ClientIndexPage(),
    },
    {
      'title': 'invoices',
      'icon': HeroIcons.banknotes,
      'isActive': false,
      'tab': const InvoiceIndexPage(),
    },
    // {
    //   'title': 'time tracking',
    //   'icon': HeroIcons.clock,
    //   'isActive': false,
    //   'tab': const Text('time tracking'),
    // },
    // {
    //   'title': 'scrum',
    //   'icon': HeroIcons.rectangleStack,
    //   'isActive': false,
    //   'tab': const Text('scrum'),
    // },
    // {
    //   'title': 'witeboard',
    //   'icon': HeroIcons.paintBrush,
    //   'isActive': false,
    //   'tab': const TestPage(),
    // },
    {
      'title': 'mockups',
      'icon': HeroIcons.deviceTablet,
      'isActive': false,
      'tab': const MockupIndexPage(),
    },
  ].obs;

  List<Map<String, dynamic>> get tabs => _tabs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onReady() async {
    _isLoading.value = false;
    update();

    super.onReady();
  }

  // change tab
  void changeTab(int index) {
    for (var element in _tabs) {
      element['isActive'] = false;
    }
    _tabs[index]['isActive'] = true;

    // if project tab is selected
    if (_tabs[index]['type'] == 'project') {
      changeProjectValues();
    }

    _selectedTab.value = index;
    update();
  }

  // change project values
  void changeProjectValues() {
    // get active project
    ProjectModel? activeProject = ActiveProjectStorage().read();

    if (activeProject == null) return;

    // find project tab
    Map item = _tabs.firstWhere((el) => el['type'] == 'project');
    item['title'] = activeProject.title;
    item['tab'] = ProjectSinglePage(
      projectId: activeProject.id,
      hasAppBar: false,
    );
  }

  // logout
  Future<void> logout() async {
    await _authServices.signOut();
  }
}
