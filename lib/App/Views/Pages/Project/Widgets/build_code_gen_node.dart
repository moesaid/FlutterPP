import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCodeGenNode extends StatelessWidget {
  final String? uuid;
  final List<ModelConfigModel> items;
  const BuildCodeGenNode({
    super.key,
    this.uuid,
    required this.items,
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
              color: Get.theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 2.sp,
              right: 2.sp,
              bottom: 2.sp,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.drag_indicator,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.3),
                ),
                Text(item.modelName != null
                    ? '${item.modelName}_model'.toPascalCase()
                    : 'Model'),
                const Spacer(),
                IconButton.filled(
                  onPressed: () => print('edit'),
                  icon: const Icon(Icons.edit),
                  iconSize: 5.sp,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(
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
                          .withOpacity(0.3),
                      child: ListView.separated(
                        itemCount: propertiesNoRelation.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) =>
                            const Divider(height: 0, thickness: 0.2),
                        itemBuilder: (_, int index) {
                          Properties property = propertiesNoRelation[index];
                          return ListTile(
                            title: Text(
                              property.name ?? 'Property',
                              style: TextStyle(fontSize: 4.sp),
                            ),
                            trailing: Badge(
                              label: Text(property.type?.type ?? 'Type'),
                              backgroundColor:
                                  property.type?.color.withOpacity(0.1),
                              textColor: property.type?.color,
                              textStyle: TextStyle(
                                fontSize: 3.5.sp,
                                color: property.type?.color,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 3.sp),
                              largeSize: 8.sp,
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
                            style: TextStyle(fontSize: 4.sp),
                          ),
                          trailing: Badge(
                            label: Text(
                              property.type?.type ?? 'Type',
                              style: TextStyle(fontSize: 3.5.sp),
                            ),
                            backgroundColor:
                                property.type?.color.withOpacity(0.1),
                            textColor: property.type?.color,
                            padding: EdgeInsets.symmetric(horizontal: 3.sp),
                            largeSize: 8.sp,
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