import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:get/get.dart';

class BuildCreateMockupInfo extends StatelessWidget {
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  final Function({required String type, required String value})
      onTitleOrDescriptionOrCategory;
  final List<Color> activeColors;
  final String activeSVG;

  final String? title, description, category;

  const BuildCreateMockupInfo({
    super.key,
    required this.onColorChange,
    required this.onSvgChange,
    required this.activeColors,
    required this.activeSVG,
    required this.onTitleOrDescriptionOrCategory,
    this.title,
    this.description,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                aweSideSheet(
                  context: context,
                  sheetPosition: SheetPosition.right,
                  footer: const SizedBox.shrink(),
                  title: 'customize mpckup avatar',
                  body: BuildIconAndGradients(
                    onColorChange: onColorChange,
                    onSvgChange: onSvgChange,
                    hasCloseButton: false,
                    alignment: PossionAlignment.topBottom,
                  ),
                );
              },
              // child: const Text('Icon and Gradients'),
              child: BuildProjectAvatar(
                colors: activeColors,
                icon: activeSVG,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'title',
                    initialValue: title,
                    onChanged: (value) => onTitleOrDescriptionOrCategory(
                      type: 'title',
                      value: value!,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter the title of the mockup',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'description',
                    initialValue: description,
                    onChanged: (value) => onTitleOrDescriptionOrCategory(
                      type: 'description',
                      value: value!,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter the description of the mockup',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FormBuilderDropdown(
                    name: 'category',
                    initialValue: category,
                    onChanged: (value) => onTitleOrDescriptionOrCategory(
                      type: 'category',
                      value: value!,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Select the category of the mockup',
                      contentPadding: EdgeInsets.all(11),
                    ),
                    items: [
                      'auto & behicles',
                      'beauty',
                      'books',
                      'business',
                      'education',
                      'entertainment',
                      'finance',
                      'food & drink',
                      'games',
                      'health',
                      'home & garden',
                      'internet',
                      'lifestyle',
                      'local',
                      'music',
                      'news',
                      'parenting',
                      'pets',
                      'politics',
                      'real estate',
                      'science',
                      'shopping',
                      'sports',
                      'technology',
                      'travel',
                      'weather',
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.capitalize!),
                          ),
                        )
                        .toList(),
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
