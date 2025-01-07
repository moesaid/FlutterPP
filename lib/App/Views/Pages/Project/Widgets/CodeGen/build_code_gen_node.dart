import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCodeGenNode extends StatelessWidget {
  final String? uuid;
  final List<ModelConfigModel> items;
  final void Function() onEditPressed;
  const BuildCodeGenNode({
    super.key,
    this.uuid,
    required this.items,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    ModelConfigModel item = items.firstWhere((e) => e.id == uuid);
    List<Properties> propertiesNoRelation = [];
    List<Properties> propertiesWithRelation = [];
    if (item.properties != null) {
      propertiesWithRelation =
          item.properties!.where((el) => el.relationName != null).toList();
      propertiesNoRelation =
          item.properties!.where((el) => el.relationName == null).toList();
    }

    return Container(
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 5,
            margin: const EdgeInsets.only(
              top: 5,
              right: 5,
              left: 5,
            ),
            decoration: BoxDecoration(
              color: item.color != null
                  ? ColorHelper.hexToColor(item.color!)
                  : Get.theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 2.spa,
              right: 2.spa,
              bottom: 2.spa,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.drag_indicator,
                  color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                Text(item.modelName != null
                    ? '${item.modelName}_model'.toPascalCase()
                    : 'Model'),
                const Spacer(),
                IconButton.filled(
                  onPressed: onEditPressed,
                  icon: const Icon(Icons.edit),
                  iconSize: 5.spa,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    backgroundColor: WidgetStateProperty.all(
                      Get.theme.colorScheme.secondaryContainer,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0, thickness: 0.5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (propertiesNoRelation.isNotEmpty)
                    Container(
                      color: Get.theme.colorScheme.secondaryContainer
                          .withValues(alpha: 0.3),
                      child: ListView.separated(
                        itemCount: propertiesNoRelation.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) =>
                            const Divider(height: 0, thickness: 0.2),
                        itemBuilder: (_, int index) {
                          Properties property = propertiesNoRelation[index];
                          // print(property.type);
                          return ListTile(
                            title: Text(
                              property.name ?? 'Property',
                              style: TextStyle(fontSize: 4.spa),
                            ),
                            trailing: Badge(
                              label: Text(property.type?.type ?? 'Type11'),
                              backgroundColor:
                                  property.type?.color.withValues(alpha: 0.1),
                              textColor: property.type?.color,
                              textStyle: TextStyle(
                                fontSize: 3.5.spa,
                                color: property.type?.color,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 3.spa),
                              largeSize: 8.spa,
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
                  if (item.relations != null)
                    const Divider(height: 0, thickness: 0.5),
                  if (item.relations != null)
                    ListView.separated(
                      itemCount: propertiesWithRelation.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const Divider(
                        height: 0,
                        thickness: 0.2,
                      ),
                      itemBuilder: (_, int index) {
                        Properties property = propertiesWithRelation[index];
                        return ListTile(
                          title: Text(
                            property.name ?? 'Property',
                            style: TextStyle(fontSize: 4.spa),
                          ),
                          trailing: Badge(
                            label: Text(
                              property.type?.type ?? 'Type',
                              style: TextStyle(fontSize: 3.5.spa),
                            ),
                            backgroundColor:
                                property.type?.color.withValues(alpha: 0.1),
                            textColor: property.type?.color,
                            padding: EdgeInsets.symmetric(horizontal: 3.spa),
                            largeSize: 8.spa,
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
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
