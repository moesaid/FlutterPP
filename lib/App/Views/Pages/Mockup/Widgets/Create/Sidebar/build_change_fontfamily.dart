import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Mockup/change_fontfamily_controller.dart';
import 'package:flutterpp/App/Views/Global/build_full_page_bottomsheet.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildChangeFontFamily extends GetView<ChangeFontfamilyController> {
  final TextStyle? fontFamily;

  const BuildChangeFontFamily({
    this.fontFamily,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeFontfamilyController>(
      init: ChangeFontfamilyController(),
      didChangeDependencies: (state) {
        if (fontFamily == null) return;
        state.controller?.changeFontFamily(fontFamily: fontFamily!);
      },
      builder: (context) {
        return InkWell(
          onTap: () => Get.bottomSheet(
            BuildChangeFontBottomSheet(
              controller: controller,
            ),
            isDismissible: false,
            enableDrag: false,
            isScrollControlled: true,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${controller.activeFontFamily.fontFamily!.split('_').first} ',
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildChangeFontBottomSheet extends StatelessWidget {
  final ChangeFontfamilyController controller;
  const BuildChangeFontBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BuildFullPageBottomSheet(
      bgColor: Get.theme.colorScheme.background,
      closeWidget: BuildBottomSheetTopNavFullWidth(
        onSave: () => controller.saveFontFamily(),
        onCancle: () => controller.onCancle(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          // BuildSearchBar(
          //   onSearch: (String search) => controller.searchFontFamily(
          //     search: search,
          //   ),
          // ),
          // const SizedBox(height: 30),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 400,
                  height: double.infinity,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.primaryContainer,
                  ),
                  child: Center(
                    child: Obx(
                      () => Text(
                        'data',
                        style: controller.preActiveFontFamily.copyWith(
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: BuildFontList(controller: controller)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildBottomSheetTopNavFullWidth extends StatelessWidget {
  final VoidCallback? onCancle, onSave;

  const BuildBottomSheetTopNavFullWidth({
    super.key,
    this.onCancle,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          border: Border(
            bottom: BorderSide(
              color: Get.theme.colorScheme.onPrimaryContainer.withOpacity(
                0.2,
              ),
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fonts', style: TextStyle(fontSize: 23)),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey.withOpacity(1),
                    backgroundColor: Colors.grey.withOpacity(0.1),
                  ),
                  onPressed: onCancle ?? () => Get.back(),
                  child: const Text(
                    'cancel',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onSave,
                  child: Text(
                    'save'.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSearchBar extends StatelessWidget {
  final Function(String search) onSearch;
  const BuildSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: FormBuilderTextField(
        name: 'search',
        decoration: const InputDecoration(
          hintText: 'Search font',
          prefixIcon: Icon(Icons.search),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(3),
          FormBuilderValidators.maxLength(20),
        ]),
        onEditingComplete: () {
          // validate
          bool? isValied = formKey.currentState?.validate();
          if (isValied == null || !isValied) return;

          // submit
          formKey.currentState?.save();
          onSearch.call(formKey.currentState?.value['search']);
        },
      ),
    );
  }
}

class BuildFontList extends StatelessWidget {
  const BuildFontList({
    super.key,
    required this.controller,
  });

  final ChangeFontfamilyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: GoogleFonts.asMap().entries.length,
      separatorBuilder: (_, int index) {
        return const Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        return GoogleFonts.asMap().entries.map((e) {
          return ListTile(
            style: ListTileStyle.drawer,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
            onTap: () => controller.changeFontFamily(
              fontFamily: e.value(),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.key,
                ),
                const SizedBox(height: 5),
                Text(
                  'Font Family ${e.value().fontFamily!}',
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  e.key,
                  style: e.value().copyWith(
                        fontSize: 60,
                      ),
                ),
              ],
            ),
          );
        }).toList()[index];
      },
    );
  }
}