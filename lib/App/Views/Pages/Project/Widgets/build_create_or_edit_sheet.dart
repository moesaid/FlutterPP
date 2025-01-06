import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
    var formKey = GlobalKey<FormBuilderState>();
    return SizedBox.expand(
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0.spa),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primaryContainer,
                border: Border(
                  bottom: BorderSide(
                    color: Get.theme.colorScheme.secondaryContainer,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    controller.tempModel.id == null
                        ? 'Create Model'
                        : 'Edit Model',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => controller.tempModel.id != null
                        ? controller.deleteModel(controller.tempModel.id ?? '')
                        : controller.resetTempModel(),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        controller.tempModel.id == null
                            ? Get.theme.colorScheme.surface
                            : Get.theme.colorScheme.errorContainer,
                      ),
                    ),
                    child: Text(
                      controller.tempModel.id == null
                          ? 'reset'.capitalize!
                          : 'delete'.capitalize!,
                    ),
                  ),
                  SizedBox(width: 5.spa),
                  FilledButton(
                    onPressed: () {
                      // validate the form
                      if (formKey.currentState!.saveAndValidate()) {
                        controller.createProjectModel();
                      }
                    },
                    child: Text(
                      'Save'.toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0.spa),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.spa),
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
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.maxWordsCount(1)
                              ]),
                              onChanged: (value) {
                                controller.updateTempModel(
                                  ModelConfigModel(modelName: value),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 4.spa),
                          SizedBox(
                            width: context.width * 0.05,
                            height: context.width * 0.035,
                            child: BuildPickColor(
                              controllerTag: 'tempModel',
                              initialColor: ColorHelper.hexToColor(
                                controller.tempModel.color ?? '332163',
                              ),
                              onColorChangedCallback: (color) {
                                controller.updateTempModel(
                                  ModelConfigModel(
                                    color: ColorHelper.colorToHexWithoutHash(
                                      color,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.spa),
                      Obx(
                        () => Text(
                          '${controller.tempModel.modelName?.toPascalCase() ?? '_'}Model',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      // Divider(height: 20.spa, thickness: 0.2),
                      SizedBox(height: 10.spa),
                      Text(
                        'options'.capitalize!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 4.spa),
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
                      Divider(height: 20.spa, thickness: 0.2),
                      BuildAddRelationshipSection(controller: controller),
                      Divider(height: 20.spa, thickness: 0.2),
                      BuildAddPropertiesSection(controller: controller),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildAddPropertiesSection extends StatelessWidget {
  const BuildAddPropertiesSection({
    super.key,
    required this.controller,
  });

  final ProjectSingleCodeGenController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleCodeGenController>(
      init: ProjectSingleCodeGenController(),
      initState: (_) {},
      builder: (_) {
        return Column(
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
                          relations: controller.tempModel.relations ?? [],
                          onAdd: (val) {
                            controller.addPropertiesToTempModel(val);
                          },
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
                    backgroundColor: Get.theme.colorScheme.primaryContainer,
                  ),
                  child: Text(
                    'Add Property',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 4.spa,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.spa),
            Column(
              children: [
                if (controller.tempModel.properties != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondaryContainer
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView.separated(
                      itemCount: controller.tempModel.properties?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) =>
                          const Divider(height: 0, thickness: 0.2),
                      itemBuilder: (_, int index) {
                        Properties property =
                            controller.tempModel.properties![index];
                        return ListTile(
                          title: Text(
                            property.name ?? 'Property',
                            style: Get.textTheme.bodyMedium,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Badge(
                                label: Text(property.type?.type ?? 'Type'),
                                backgroundColor:
                                    property.type?.color.withValues(alpha: 0.1),
                                textColor: property.type?.color,
                                textStyle: Get.textTheme.bodyMedium?.copyWith(
                                  fontSize: context.width * 0.01,
                                  color: property.type?.color,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.width * 0.008,
                                  vertical: context.width * 0.002,
                                ),
                              ),
                              SizedBox(width: context.width * 0.001),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  controller.removePropertiesFromTempModel(
                                    index,
                                  );
                                },
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: context.width * 0.014,
                                  color: Get.theme.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 0,
                            bottom: 0,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class BuildAddPropertyDialog extends StatelessWidget {
  final List<String> types;
  final List<Relations>? relations;
  final Function(Properties) onAdd;
  const BuildAddPropertyDialog({
    super.key,
    required this.types,
    this.relations,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return BuildDefultDialog(
      height: 300,
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Property',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.spa),
            Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    labelText: 'Property Name',
                    hintText: 'Enter property name',
                  ),
                ),
                SizedBox(height: 5.spa),
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
                SizedBox(height: 5.spa),
                if (relations != null && relations!.isNotEmpty)
                  FormBuilderDropdown(
                    name: 'relation_name',
                    decoration: const InputDecoration(
                      labelText:
                          'link to a model (applicable for hasOne and hasMany)',
                    ),
                    items: relations!
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.name,
                            child: Text(e.name!.capitalize!),
                          ),
                        )
                        .toList(),
                  ),
                SizedBox(height: 5.spa),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.saveAndValidate()) {
                            // value
                            String? propertyName =
                                formKey.currentState!.fields['name']?.value;

                            // type
                            String? type =
                                formKey.currentState!.fields['type']?.value;

                            // relation
                            String? relationName = formKey
                                .currentState!.fields['relation_name']?.value;

                            if ((type == 'hasOne' || type == 'hasMany') &&
                                (relationName == null)) {
                              BuildSnackBar(
                                      title: 'Oops!',
                                      message:
                                          'No models found or inapplicable, cannot add relation properties.')
                                  .error();
                              return;
                            }

                            // if any of the fields are empty
                            if (propertyName == null || type == null) {
                              BuildSnackBar(
                                title: 'Oops!',
                                message:
                                    'property name or type cannot be empty.',
                              ).error();
                              return;
                            }

                            // if relationName is not null the type should be hasOne or hasMany
                            if (relationName != null &&
                                (type != 'hasOne' && type != 'hasMany')) {
                              BuildSnackBar(
                                title: 'Oops!',
                                message:
                                    'relation name is only applicable for hasOne and hasMany types.',
                              ).error();
                              return;
                            }

                            onAdd(
                              Properties(
                                name: propertyName,
                                type: PropertieType.values
                                    .firstWhere((e) => e.name == type),
                                relationName: relationName,
                              ),
                            );
                            Get.back();
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 4.spa,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.spa),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.surface,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 4.spa,
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
                      debugPrint(controller.tempModel.modelName);
                      return BuildAddRelationshipModel(
                        models: controller.models
                            .where((el) =>
                                el.modelName != controller.tempModel.modelName)
                            .map((e) => e.modelName!)
                            .toList(),
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
                  fontSize: 4.spa,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.spa),
        Obx(
          () => SizedBox(
            height: 10.spa,
            width: double.infinity,
            child: ListView.separated(
              itemCount: controller.tempModel.relations?.length ?? 0,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 2.spa);
              },
              itemBuilder: (BuildContext context, int index) {
                String? item = controller.tempModel.relations?[index].name;
                return Badge(
                  backgroundColor: Get.theme.colorScheme.secondaryContainer,
                  largeSize: 10.spa,
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.spa,
                    vertical: 0,
                  ),
                  textColor: Colors.white,
                  label: Row(
                    children: [
                      Text(item != null ? '${item.capitalize}Model' : ''),
                      SizedBox(width: 2.spa),
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
                          size: 4.spa,
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
          SizedBox(height: 10.spa),
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
              SizedBox(height: 5.spa),
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
                          fontSize: 4.spa,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.spa),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.colorScheme.surface,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4.spa,
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
