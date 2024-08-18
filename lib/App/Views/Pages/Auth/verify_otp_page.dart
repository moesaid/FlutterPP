import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Auth/verify_otp_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
                          style: Get.theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'we have sent you a OTP code to your email address',
                          style: Get.theme.textTheme.bodySmall,
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
                                  onPressed: () async {
                                    if (formKey.currentState
                                            ?.saveAndValidate() ==
                                        true) {
                                      await controller.verifyOtp(
                                          formKey.currentState?.value);
                                      formKey.currentState?.reset();
                                    }
                                  },
                                  child: const Text('verify'),
                                ),
                              ),
                              SizedBox(height: 10.spa),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: controller.needToResendOtp
                                        ? () => controller.resendOtp()
                                        : null,
                                    child: AnimatedDefaultTextStyle(
                                      style: TextStyle(
                                        color: controller.needToResendOtp
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      child: Text(
                                        'resend otp'.toUpperCase(),
                                      ),
                                    ),
                                  ),
                                  if (controller.sentCount.isGreaterThan(0))
                                    Obx(
                                      () => Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Get.theme.colorScheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          controller.sentCount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 4.spa,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 10.spa),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'go back to login page',
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.onSurface,
                                  ),
                                ),
                              )
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
