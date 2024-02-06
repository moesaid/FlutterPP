import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
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
              BuildAddRelationshipSection(controller: controller),
              Divider(height: 20.sp, thickness: 0.2),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'properties'.capitalize!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BuildAddPropertyDialog(
                                types: PropertieType.names,
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Get.theme.colorScheme.onPrimaryContainer,
                          backgroundColor:
                              Get.theme.colorScheme.primaryContainer,
                        ),
                        child: Text(
                          'Add Property',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 4.sp,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildAddPropertyDialog extends StatelessWidget {
  final List<String> types;
  final List<Relations>? relations;
  const BuildAddPropertyDialog({
    super.key,
    required this.types,
    this.relations,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return BuildDefultDialog(
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Text(
              'Add Property',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.sp),
            Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    labelText: 'Property Name',
                    hintText: 'Enter property name',
                  ),
                ),
                SizedBox(height: 5.sp),
                FormBuilderDropdown(
                  name: 'type',
                  decoration: const InputDecoration(
                    labelText: 'Type',
                  ),
                  items: types
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 5.sp),
                if (relations != null && relations!.isNotEmpty)
                  FormBuilderDropdown(
                    name: 'relation_name',
                    decoration: const InputDecoration(
                      labelText: 'link to a model',
                    ),
                    items: relations!
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name!.capitalize!),
                          ),
                        )
                        .toList(),
                  ),
                SizedBox(height: 5.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.saveAndValidate()) {
                            // value
                            String? propertyName =
                                formKey.currentState!.fields['name']!.value;

                            // type
                            String? type =
                                formKey.currentState!.fields['type']!.value;

                            // relation
                            String? relationName = formKey
                                .currentState!.fields['relation_name']!.value;

                            if ((type == 'hasOne' || type == 'hasMany') &&
                                (relations == null || relations!.isEmpty)) {
                              print('no relations');
                            }

                            // Todo: add to temp model
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 4.sp,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.sp),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.background,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 4.sp,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildAddRelationshipSection extends StatelessWidget {
  const BuildAddRelationshipSection({
    super.key,
    required this.controller,
  });

  final ProjectSingleCodeGenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Has relationships?'.capitalize!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            TextButton(
              onPressed: () {
                if (controller.models.isEmpty) {
                  BuildSnackBar(
                    title: 'No models found',
                    message: 'Please create a model first',
                  ).error();
                  return;
                }

                if (controller.models.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BuildAddRelationshipModel(
                        models:
                            controller.models.map((e) => e.modelName!).toList(),
                        onAdd: (val) {
                          controller.addRelationToTempModel(
                            Relations(name: val),
                          );
                        },
                      );
                    },
                  );
                }
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
        Obx(
          () => SizedBox(
            height: 10.sp,
            width: double.infinity,
            child: ListView.separated(
              itemCount: controller.tempModel.relations?.length ?? 0,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 2.sp);
              },
              itemBuilder: (BuildContext context, int index) {
                String? item = controller.tempModel.relations?[index].name;
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
                      Text(item != null ? '${item.capitalize}Model' : ''),
                      SizedBox(width: 2.sp),
                      InkWell(
                        onTap: () {
                          controller.updateTempModel(
                            ModelConfigModel(
                              relations: controller.tempModel.relations!
                                ..removeAt(index),
                            ),
                          );
                        },
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
          ),
        ),
      ],
    );
  }
}

class BuildAddRelationshipModel extends StatelessWidget {
  final List<String> models;
  final Function(String) onAdd;
  const BuildAddRelationshipModel({
    super.key,
    required this.models,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return BuildDefultDialog(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Relationship',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10.sp),
          Column(
            children: [
              FormBuilder(
                key: formKey,
                child: FormBuilderDropdown(
                  name: 'model',
                  decoration: InputDecoration(
                    labelText: 'select a model'.capitalize!,
                  ),
                  items: [
                    for (String model in models)
                      DropdownMenuItem(
                        value: model,
                        child: Text('${model}Model'.toPascalCase()),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 5.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate() &&
                            formKey.currentState!.fields['model']!.value !=
                                null) {
                          onAdd(formKey.currentState!.fields['model']!.value);
                          Get.back();
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 4.sp,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.sp),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.colorScheme.background,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4.sp,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
