import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class BuildAppFlowyHeader extends StatelessWidget {
  const BuildAppFlowyHeader({
    Key? key,
    required this.appFlowyController,
    required this.columnData,
    required this.updateBoard,
  }) : super(key: key);

  final AppFlowyBoardController appFlowyController;
  final AppFlowyGroupData columnData;
  final Function(Map) updateBoard;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return AppFlowyGroupHeader(
      height: 50,
      moreIcon: const Icon(Icons.more_vert, size: 20),
      onMoreButtonClick: () {
        Get.defaultDialog(
          radius: 6,
          title: 'update board title'.capitalize!,
          titlePadding: const EdgeInsets.all(20),
          titleStyle: Get.textTheme.headline6,
          contentPadding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: formKey,
                child: FormBuilderTextField(
                  name: 'title',
                  decoration: InputDecoration(
                    labelText: 'title'.capitalize!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.saveAndValidate()) {
                    Map data = {
                      'id': columnData.id,
                      'title': formKey.currentState!.value['title'],
                    };

                    await updateBoard(data);
                    Get.back();
                  }
                },
                child: const Text('Update'),
              )
            ],
          ),
        );
      },
      title: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(columnData.headerData.groupName),
        ),
      ),
    );
  }
}

class BuildAppFlowyFooter extends StatelessWidget {
  final AppFlowyGroupData columnData;
  final Function(Map) addTask;
  const BuildAppFlowyFooter({
    Key? key,
    required this.columnData,
    required this.addTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppFlowyGroupFooter(
      height: 50,
      icon: const Icon(Icons.add, size: 20),
      title: const Text('Add Card'),
      onAddButtonClick: () {
        Get.bottomSheet(
          BuildAddTaskBottomsheet(addTask: addTask),
          isScrollControlled: true,
        );
      },
    );
  }
}

class BuildAddTaskBottomsheet extends StatelessWidget {
  final Function(Map) addTask;

  const BuildAddTaskBottomsheet({
    Key? key,
    required this.addTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        border: Border(
          top: BorderSide(color: Get.theme.colorScheme.primaryContainer),
        ),
      ),
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned(
            top: 20,
            right: 20,
            child: CloseButton(),
          ),
          SizedBox(
            width: 500,
            child: FormBuilder(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Create Task'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    child: FormBuilderDropdown(
                      name: 'status',
                      decoration: InputDecoration(
                        labelText: 'status'.capitalize!,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      initialValue: 'todo',
                      items: const [
                        DropdownMenuItem(
                          value: 'todo',
                          child: Text('To Do'),
                        ),
                        DropdownMenuItem(
                          value: 'inprogress',
                          child: Text('In Progress'),
                        ),
                        DropdownMenuItem(
                          value: 'done',
                          child: Text('Done'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'title',
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'description',
                    decoration: const InputDecoration(labelText: 'Description'),
                    minLines: 3,
                    maxLines: 5,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  // Due date
                  FormBuilderDateTimePicker(
                    name: 'due_date',
                    inputType: InputType.date,
                    decoration: const InputDecoration(labelText: 'Due Date'),
                    initialValue: DateTime.now().add(const Duration(days: 30)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  // start date
                  FormBuilderDateTimePicker(
                    name: 'start_date',
                    inputType: InputType.date,
                    decoration: const InputDecoration(labelText: 'Start Date'),
                    initialValue: DateTime.now(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  // Priority
                  FormBuilderDropdown(
                    name: 'priority',
                    decoration: const InputDecoration(labelText: 'Priority'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    initialValue: 'medium',
                    items: const [
                      DropdownMenuItem(
                        value: 'highest',
                        child: Text('Highest'),
                      ),
                      DropdownMenuItem(
                        value: 'high',
                        child: Text('High'),
                      ),
                      DropdownMenuItem(
                        value: 'medium',
                        child: Text('Medium'),
                      ),
                      DropdownMenuItem(
                        value: 'low',
                        child: Text('Low'),
                      ),
                      DropdownMenuItem(
                        value: 'lowest',
                        child: Text('Lowest'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Get.theme.colorScheme.primaryContainer,
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.saveAndValidate()) {
                            Map<String, dynamic> data =
                                formKey.currentState!.value;
                            addTask(data);
                            Get.back();
                          }
                        },
                        child: const Text('Create'),
                      ),
                    ],
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

class TextItem extends AppFlowyGroupItem {
  final String s;
  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}

class RichTextCard extends StatelessWidget {
  final String item;
  const RichTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.secondaryContainer,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
