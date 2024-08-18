import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSearchForm extends StatelessWidget {
  final void Function(String)? onSearch;
  final void Function()? onClear;
  final String? searchKey;
  const BuildSearchForm({
    super.key,
    this.onSearch,
    this.searchKey,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Container(
        width: context.width * 0.2,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(
          horizontal: 4.spa,
          vertical: 2.spa,
        ),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: 'name',
                initialValue: searchKey,
                scrollPadding: EdgeInsets.zero,
                cursorHeight: 15,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2.spa,
                    horizontal: 0,
                  ),
                  isDense: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: Get.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.spa),
            InkWell(
              onTap: () {
                if (searchKey != null && searchKey!.isNotEmpty) {
                  onClear?.call();
                  return;
                }

                if (formKey.currentState?.saveAndValidate() == true) {
                  onSearch?.call(formKey.currentState?.value['name']);
                }
              },
              child: Icon(
                (searchKey != null && searchKey!.isNotEmpty)
                    ? Icons.close
                    : Icons.search_rounded,
                size: 6.spa,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
