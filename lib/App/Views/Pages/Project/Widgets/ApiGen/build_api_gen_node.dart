import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Global/build_api_gen_node_controller.dart';
import 'package:flutterpp/Config/app_print.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class BuildApiGenNode extends GetView<BuildApiGenNodeController> {
  const BuildApiGenNode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BuildApiGenNodeController(),
      tag: 'api-gen-node-${const Uuid().v4()}',
      builder: (_) {
        return MouseRegion(
          onHover: (event) => _.toggleHovring(true),
          onExit: (event) => _.toggleHovring(false),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5.sp),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: context.width * 0.25,
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(2.sp),
                    border: Border.all(
                      color: _.isHovring
                          ? Get.theme.colorScheme.inversePrimary
                          : Get.theme.colorScheme.secondaryContainer,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.width * 0.007,
                          horizontal: context.width * 0.01,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.api, size: context.width * 0.011),
                            SizedBox(width: context.width * 0.005),
                            Text(
                              'rest api call'.capitalize!,
                              style: TextStyle(fontSize: context.width * 0.01),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => AppPrint.print('data'),
                              child:
                                  Icon(Icons.link, size: context.width * 0.012),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 0, thickness: 0.5),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.width * 0.007,
                          horizontal: context.width * 0.01,
                        ),
                        child: FormBuilder(
                          child: Column(
                            children: [
                              const BuildApiGenFormTextItem(
                                title: 'path',
                                value: '/api/v1/users',
                              ),
                              SizedBox(height: context.width * 0.005),
                              const BuildApiGenFormDropdownItem(
                                title: 'Method',
                                value: 'post',
                              ),
                              SizedBox(height: context.width * 0.005),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: context.width * 0.002,
                child: InkWell(
                  onTap: () => AppPrint.print('add workflow'),
                  onHover: (value) => _.togglePlusHovring(value),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: _.isPlusHovering ? 1.2 : 1,
                    child: Container(
                      width: context.width * 0.015,
                      height: context.width * 0.015,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.colorScheme.primaryContainer,
                        border: Border.all(
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
                      child: Icon(Icons.add_rounded, size: 5.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildApiGenFormTextItem extends StatelessWidget {
  final String? title, value;

  const BuildApiGenFormTextItem({
    super.key,
    this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title?.capitalize ?? '',
            style: TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontSize: context.width * 0.01,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            child: FormBuilderTextField(
              name: title ?? '',
              initialValue: value ?? '',
              style: TextStyle(fontSize: context.width * 0.01),
              cursorHeight: context.width * 0.01,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.width * 0.008,
                  horizontal: context.width * 0.007,
                ),
                fillColor: Get.theme.colorScheme.background,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.theme.colorScheme.inversePrimary,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildApiGenFormDropdownItem extends StatelessWidget {
  final String? title, value;

  const BuildApiGenFormDropdownItem({
    super.key,
    this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title?.capitalize ?? '',
            style: TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontSize: context.width * 0.01,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            child: FormBuilderDropdown(
              isDense: true,
              name: title ?? '',
              initialValue: value,
              dropdownColor: Get.theme.colorScheme.background,
              style: TextStyle(fontSize: context.width * 0.01),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.width * 0.006,
                  horizontal: context.width * 0.007,
                ),
                fillColor: Get.theme.colorScheme.background,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.theme.colorScheme.inversePrimary,
                  ),
                ),
              ),
              items: ['get', 'post', 'put', 'delete']
                  .map((item) => DropdownMenuItem(
                        alignment: AlignmentDirectional.centerStart,
                        value: item,
                        child: Text(item.toUpperCase()),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
