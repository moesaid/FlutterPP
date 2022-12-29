import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Auth/verify_otp_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return GetBuilder(
        init: VerifyOtpController(),
        initState: (_) {},
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: 500,
                  child: FormBuilder(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Enter Code',
                          style: Get.theme.textTheme.headline5,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'we have sent you a OTP code to your email address',
                          style: Get.theme.textTheme.caption,
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'otp',
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'OTP',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  FormBuilderValidators.minLength(6),
                                  FormBuilderValidators.maxLength(6),
                                ]),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!
                                        .saveAndValidate()) {
                                      controller.verifyOtp(
                                        formKey.currentState!.value,
                                      );
                                    }
                                  },
                                  child: const Text('verify'),
                                ),
                              ),
                              const SizedBox(height: 50),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: controller.needToResendOtp ? 1 : 0,
                                child: TextButton(
                                  onPressed: () {
                                    controller.resendOtp();
                                  },
                                  child: Text(
                                    'resend otp'.toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
