import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Auth/signup_controller.dart';
import 'package:flutterpp/App/Views/Global/build_logo.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return GetBuilder<SignupController>(
      init: SignupController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BuildLogo(size: 22.spa),
                    SizedBox(height: 4.spa),
                    Text(
                      'Sign up for Flutter++',
                      style: Get.theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'to start creating and sharing your projects.',
                      style: Get.theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 14.spa),
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderTextField(
                            name: 'name',
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(10),
                              FormBuilderValidators.minLength(3),
                            ]),
                            maxLines: 1,
                          ),
                          SizedBox(height: 4.spa),
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
                          SizedBox(height: 4.spa),
                          FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(8),
                            ]),
                          ),
                          SizedBox(height: 8.spa),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState == null) return;
                                if (formKey.currentState?.saveAndValidate() ==
                                    true) {
                                  await controller.signup(
                                    formKey.currentState?.value,
                                  );

                                  formKey.currentState?.reset();
                                }
                              },
                              child: const Text('sign up'),
                            ),
                          ),
                          SizedBox(height: 10.spa),
                          const Text(
                            'do you have an account?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 2.spa),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => Get.toNamed(AppRoutes.LOGIN),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  minimumSize: Size.zero,
                                ),
                                child: Text(
                                  'login'.toUpperCase(),
                                  style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
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
      },
    );
  }
}
