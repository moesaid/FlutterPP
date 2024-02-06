import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCreateOrEditSheet extends StatelessWidget {
  const BuildCreateOrEditSheet({
    super.key,
    required this.controller,
  });

  final ProjectSingleCodeGenController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: FormBuilder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                controller.tempModel.id == null ? 'Create Model' : 'Edit Model',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'modelName',
                      initialValue: controller.tempModel.modelName,
                      decoration: const InputDecoration(
                        labelText: 'Model Name',
                        hintText: 'Enter model name',
                      ),
                      onChanged: (value) {
                        controller.updateTempModel(
                          ModelConfigModel(modelName: value),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 4.sp),
                  SizedBox(
                    width: 20.sp,
                    height: 16.sp,
                    child: BuildPickColor(
                      controllerTag: 'tempModel',
                      initialColor: ColorHelper.hexToColor(
                        controller.tempModel.color ?? '332163',
                      ),
                      onColorChangedCallback: (color) {
                        controller.updateTempModel(
                          ModelConfigModel(
                            color: ColorHelper.colorToHexWithoutHash(color),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.sp),
              Obx(
                () => Text(
                  '${controller.tempModel.modelName?.toPascalCase() ?? '_'}Model',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              // Divider(height: 20.sp, thickness: 0.2),
              SizedBox(height: 10.sp),
              Text(
                'options'.capitalize!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 4.sp),
              FormBuilderCheckbox(
                name: 'isCrud',
                title: const Text('enable CRUD pages and controllers'),
                initialValue: controller.tempModel.isCrud,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  controller.updateTempModel(
                    ModelConfigModel(isCrud: value),
                  );
                },
              ),
              Divider(height: 20.sp, thickness: 0.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Has relationships?'.capitalize!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton(
                    onPressed: () {
                      // open modal
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const BuiuldDialog();
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
                      backgroundColor: Get.theme.colorScheme.primaryContainer,
                    ),
                    child: Text(
                      'Add Relationship',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4.sp,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.sp),
              SizedBox(
                height: 10.sp,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: controller.tempModel.relations?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 2.sp);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Badge(
                      backgroundColor: Get.theme.colorScheme.secondaryContainer,
                      largeSize: 10.sp,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.sp,
                        vertical: 0,
                      ),
                      textColor: Colors.white,
                      label: Row(
                        children: [
                          Text('name'.capitalize!),
                          SizedBox(width: 2.sp),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.close,
                              size: 4.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuiuldDialog extends StatelessWidget {
  final Widget? child;
  const BuiuldDialog({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ??
            const Center(
              child: Text('Modal'),
            ),
      ),
    );
  }
}
