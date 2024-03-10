import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Views/Global/build_logo.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return GetBuilder<LoginController>(
        init: LoginController(),
        initState: (_) {},
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BuildLogo(size: 12.sp),
                      SizedBox(height: 4.sp),
                      Text('Login', style: Get.theme.textTheme.headlineSmall),
                      SizedBox(height: 4.sp),
                      Text(
                        'welcome back to flutter++ ',
                        style: Get.theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 16.sp),
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormBuilderTextField(
                              name: 'email',
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            SizedBox(height: 3.sp),
                            SizedBox(
                              width: Get.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState == null) return;

                                  if (formKey.currentState!.saveAndValidate()) {
                                    controller
                                        .login(formKey.currentState!.value);
                                  }
                                },
                                child: const Text('login'),
                              ),
                            ),
                            SizedBox(height: 10.sp),
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4.sp),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  size: 14,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                const SizedBox(width: 5),
                                TextButton(
                                  onPressed: () => Get.back(),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    minimumSize: Size.zero,
                                  ),
                                  child: Text(
                                    'sign up'.toUpperCase(),
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
