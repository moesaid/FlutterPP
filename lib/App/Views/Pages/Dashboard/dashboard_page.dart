import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await AuthServices().signOut();
                    },
                    child: const Text('sign out'),
                  ),
                  SizedBox(height: 5.h),
                  ElevatedButton(
                    onPressed: () async {
                      print('❌ start pick image');
                      await FileManegerProvider().pickFile();
                      print('❌ end pick image');
                    },
                    child: const Text('pick image'),
                  ),
                  SizedBox(height: 5.h),
                  ElevatedButton(
                    onPressed: () async {
                      print('❌ start pick image');
                      await FileManegerProvider().deleteFolder(
                        folderName: 'moe',
                        location: '/Users/moe/Desktop',
                      );
                      print('❌ end pick image');
                    },
                    child: const Text('save file'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
