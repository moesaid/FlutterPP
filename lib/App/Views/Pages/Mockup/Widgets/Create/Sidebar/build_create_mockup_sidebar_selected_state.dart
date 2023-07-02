import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Models/background_type_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedState
    extends GetView<BuildCreateMockupSidebarSelectedStateController> {
  const BuildCreateMockupSidebarSelectedState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
      init: BuildCreateMockupSidebarSelectedStateController(),
      initState: (_) {},
      builder: (_) {
        return ExpansionTileGroup(
          toggleType: ToggleType.expandOnlyCurrent,
          children: [
            _buildLayoutStep(),
            ExpansionTileBorderItem(
              title: const Text('Background'),
              leading: const Icon(Icons.crop_original_rounded),
              collapsedBorderColor: Colors.transparent,
              collapsedTextColor: Colors.grey.withOpacity(0.8),
              collapsedIconColor: Colors.grey.withOpacity(0.8),
              expendedBorderColor: Colors.grey.withOpacity(0.2),
              textColor: Colors.white,
              iconColor: Colors.white,
              children: [
                BuildSidebarOption(
                  title: 'Type',
                  rightWidget: DropdownButton<String>(
                    value: controller.activeBackgroundType.name,
                    icon: const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.arrow_downward, size: 15),
                        ],
                      ),
                    ),
                    isDense: true,
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    focusColor: Colors.transparent,
                    underline: Container(height: 0),
                    onChanged: (String? value) {
                      controller.onSelectBackgroundType(name: value ?? '');
                    },
                    items: controller.backgroundTypeList
                        .map<DropdownMenuItem<String>>(
                      (BackgroundTypeModel el) {
                        return DropdownMenuItem<String>(
                          value: el.name,
                          child: Text(
                            el.name!.capitalize!,
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const Divider(height: 20),
                if (controller.activeBackgroundType.id == 'solid')
                  const _BuildSolidColorOption(),
                if (controller.activeBackgroundType.id == 'gradient')
                  const _BuildColorPresetGradient(),
                if (controller.activeBackgroundType.id == 'image')
                  const Text('Image'),
              ],
            ),
            ExpansionTileBorderItem(
              title: const Text('Icon'),
              leading: const Icon(Icons.invert_colors_on_sharp),
              collapsedBorderColor: Colors.transparent,
              collapsedTextColor: Colors.grey.withOpacity(0.8),
              collapsedIconColor: Colors.grey.withOpacity(0.8),
              expendedBorderColor: Colors.grey.withOpacity(0.2),
              textColor: Colors.white,
              iconColor: Colors.white,
              children: const [
                Text('Title of expansion tile item 2'),
              ],
            ),
            ExpansionTileBorderItem(
              title: const Text('Title'),
              leading: const Icon(Icons.text_fields),
              collapsedBorderColor: Colors.transparent,
              collapsedTextColor: Colors.grey.withOpacity(0.8),
              collapsedIconColor: Colors.grey.withOpacity(0.8),
              expendedBorderColor: Colors.grey.withOpacity(0.2),
              textColor: Colors.white,
              iconColor: Colors.white,
              children: const [
                Text('Title of expansion tile item 2'),
              ],
            ),
            ExpansionTileBorderItem(
              title: const Text('Subtitle'),
              leading: const Icon(Icons.text_increase),
              collapsedBorderColor: Colors.transparent,
              collapsedTextColor: Colors.grey.withOpacity(0.8),
              collapsedIconColor: Colors.grey.withOpacity(0.8),
              expendedBorderColor: Colors.grey.withOpacity(0.2),
              textColor: Colors.white,
              iconColor: Colors.white,
              children: const [
                Text('Title of expansion tile item 2'),
              ],
            ),
            ExpansionTileBorderItem(
              title: const Text('Device'),
              leading: const Icon(Icons.devices),
              collapsedBorderColor: Colors.transparent,
              collapsedTextColor: Colors.grey.withOpacity(0.8),
              collapsedIconColor: Colors.grey.withOpacity(0.8),
              expendedBorderColor: Colors.grey.withOpacity(0.2),
              textColor: Colors.white,
              iconColor: Colors.white,
              children: const [
                Text('Title of expansion tile item 2'),
              ],
            ),
            ExpansionTileBorderItem(
              title: const Text('Device Two'),
              leading: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.devices),
                  Icon(Icons.looks_two_outlined),
                ],
              ),
              collapsedBorderColor: Colors.transparent,
              collapsedTextColor: Colors.grey.withOpacity(0.8),
              collapsedIconColor: Colors.grey.withOpacity(0.8),
              expendedBorderColor: Colors.grey.withOpacity(0.2),
              textColor: Colors.white,
              iconColor: Colors.white,
              children: const [
                Text('Title of expansion tile item 2'),
              ],
            ),
          ],
        );
      },
    );
  }

  ExpansionTileBorderItem _buildLayoutStep() {
    return ExpansionTileBorderItem(
      title: const Text('Layout'),
      leading: const Icon(Icons.crop_free),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        InkWell(
          onTap: () => print('open layout dialog'),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: const Row(
              children: [
                Expanded(child: Text('Screen name')),
                Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildColorPresetGradient extends StatelessWidget {
  const _BuildColorPresetGradient();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSidebarOption(
          title: 'preset',
          rightWidget: InkWell(
            onTap: () => print('open gradient dialog'),
            child: const Text('data'),
          ),
        )
      ],
    );
  }
}

class _BuildSolidColorOption extends StatelessWidget {
  const _BuildSolidColorOption();

  @override
  Widget build(BuildContext context) {
    return BuildSidebarOption(
      title: 'Color',
      rightWidget: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  '10%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
