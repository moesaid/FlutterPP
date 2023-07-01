import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCreateMockupChooseTemplate extends StatelessWidget {
  final Function(String templateId) onTemplateChange;
  final String templateId;
  const BuildCreateMockupChooseTemplate({
    super.key,
    required this.onTemplateChange,
    required this.templateId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: ListView.separated(
          itemCount: array.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) {
            return const SizedBox(width: 10);
          },
          itemBuilder: (ctx, int index) {
            return InkWell(
              onTap: () => onTemplateChange(array[index]),
              child: Container(
                width: 500,
                height: 300,
                decoration: BoxDecoration(
                  color: templateId == array[index]
                      ? Get.theme.colorScheme.secondary.withOpacity(
                          0.4,
                        )
                      : Get.theme.colorScheme.primaryContainer,
                  border: Border.all(
                    color: templateId == array[index]
                        ? Get.theme.colorScheme.onPrimaryContainer.withOpacity(
                            0.2,
                          )
                        : Get.theme.colorScheme.onPrimaryContainer.withOpacity(
                            0.1,
                          ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 14,
                        ),
                        child: Text('${array[index]} Template'.capitalize!),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/templates/${array[index]}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// array
var array = <String>[
  'airbnb',
  'spotify',
  'cricut',
  'googleone',
  'tandem',
  'medium',
];
