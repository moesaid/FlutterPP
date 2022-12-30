import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Auth/signup_controller.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign up for Flutter++',
                  style: Get.theme.textTheme.headline5,
                ),
                const SizedBox(height: 10),
                Text(
                  'to start creating and sharing your projects.',
                  style: Get.theme.textTheme.caption,
                ),
                const SizedBox(height: 20),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.saveAndValidate()) {
                              controller.signup(formKey.currentState!.value);
                            }
                          },
                          child: const Text('sign up'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'do you have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                            color: Get.isDarkMode ? Colors.white : Colors.black,
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
  }
}
