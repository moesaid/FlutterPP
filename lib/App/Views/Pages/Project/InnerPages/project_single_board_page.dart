// import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_board_controller.dart';
import 'package:get/get.dart';

class ProjectSingleBoardPage extends GetView<ProjectSingleBoardController> {
  const ProjectSingleBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleBoardController>(
      init: ProjectSingleBoardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            appBar: AppBar(title: const Text('ProjectSingleBoardPage')),
            body: const SafeArea(child: Text('ProjectSingleBoardController')));
      },
    );
  }
}

// class ProjectSingleBoardPage extends GetView<ProjectSingleBoardController> {
//   const ProjectSingleBoardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // config
//     AppFlowyBoardConfig config = AppFlowyBoardConfig(
//       groupBackgroundColor: Get.theme.colorScheme.primaryContainer,
//       cornerRadius: 10,
//     );
//     final formKey = GlobalKey<FormBuilderState>();
//     final bottomFormKey = GlobalKey<FormBuilderState>();

//     return GetBuilder<ProjectSingleBoardController>(
//       init: ProjectSingleBoardController(),
//       initState: (_) {},
//       builder: (_) {
//         return Scaffold(
//           body: SafeArea(
//             child: controller.isLoading
//                 ? const BuildLoadingPage()
//                 : controller.boards.isEmpty
//                     ? _BuildEmptyState(
//                         formKey: formKey,
//                         createBoard: (data) => controller.createBoard(data),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             BuildHeaderWithNumbers(
//                               bottomFormKey: bottomFormKey,
//                               controller: controller,
//                             ),
//                             const Divider(height: 40),
//                             Expanded(
//                               child: AppFlowyBoard(
//                                 controller: controller.boardController,
//                                 cardBuilder: (context, group, groupItem) {
//                                   return AppFlowyGroupCard(
//                                     decoration: BoxDecoration(
//                                       color: Get
//                                           .theme.colorScheme.secondaryContainer,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     key: ValueKey(groupItem.id),
//                                     child: _buildCard(groupItem),
//                                   );
//                                 },
//                                 headerBuilder: (context, columnData) {
//                                   return BuildAppFlowyHeader(
//                                     appFlowyController:
//                                         controller.boardController,
//                                     updateBoard: (data) =>
//                                         controller.updateBoardName(data),
//                                     columnData: columnData,
//                                   );
//                                 },
//                                 footerBuilder: (context, columnData) {
//                                   return BuildAppFlowyFooter(
//                                     columnData: columnData,
//                                     addTask: (data) => controller.addTask(
//                                       data.cast<String, dynamic>(),
//                                       columnData,
//                                     ),
//                                   );
//                                 },
//                                 groupConstraints: const BoxConstraints.tightFor(
//                                   width: 250,
//                                 ),
//                                 config: config,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//           ),
//         );
//       },
//     );
//   }
// }

// class BuildHeaderWithNumbers extends StatelessWidget {
//   const BuildHeaderWithNumbers({
//     Key? key,
//     required this.bottomFormKey,
//     required this.controller,
//   }) : super(key: key);

//   final GlobalKey<FormBuilderState> bottomFormKey;
//   final ProjectSingleBoardController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Boards: ${controller.boards.length}  -   Tasks: ${controller.countTasks()}',
//         ),
//         OutlinedButton(
//           onPressed: () => Get.bottomSheet(
//             BuildAddBoardBootomsheet(
//               formKey: bottomFormKey,
//               createBoard: (data) => controller.createBoard(data),
//             ),
//           ),
//           child: const Text('Add Board'),
//         )
//       ],
//     );
//   }
// }

// class BuildAddBoardBootomsheet extends StatelessWidget {
//   final GlobalKey<FormBuilderState> formKey;
//   final Function(Map<String, dynamic>) createBoard;

//   const BuildAddBoardBootomsheet({
//     Key? key,
//     required this.formKey,
//     required this.createBoard,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Get.theme.colorScheme.background,
//         border: Border(
//           top: BorderSide(color: Get.theme.colorScheme.primaryContainer),
//         ),
//       ),
//       height: 500,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FormBuilder(
//             key: formKey,
//             child: SizedBox(
//               width: 300,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Create a new board'),
//                   const SizedBox(height: 20),
//                   FormBuilderTextField(
//                     name: 'title',
//                     decoration: const InputDecoration(
//                       labelText: 'Board Title',
//                     ),
//                     validator: FormBuilderValidators.required(),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState!.saveAndValidate()) {
//                         createBoard(formKey.currentState!.value);
//                         Get.back();
//                       }
//                     },
//                     child: const Text('Create Board'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _BuildEmptyState extends StatelessWidget {
//   final Function(Map<String, dynamic>) createBoard;
//   final GlobalKey<FormBuilderState> formKey;
//   final List<String> message = [
//     "Alrighty dev, let's get this code party started! Time to create a board that will knock your socks off. Or, at the very least, make them slightly askew.",
//     "It's time to unleash your inner hacker and create a masterpiece that will have people talking for centuries to come. Or at least until the next big board-making sensation comes along. Let's git this party started!",
//     "It's time to add some excitement to your life by creating a board that will knock your socks clean off. And maybe even your shoes, if we're really pushing the envelope here. Let's debug this party started!",
//     "It's time to get your craft on and create a board that will be the envy of all your peers. Or at least the ones who are into that sort of thing. Don't be shy, let's push to master!",
//     "It's time to let your creativity run wild and make something that will knock your socks off. Or at least make them slightly askew. Let's branch out and get this party started!",
//     "Grab your glue gun, paint brushes and let's get this party started! You're about to create something that will knock your socks off, or at the very least make them slightly askew. And let's not forget to add some comments for future reference."
//   ];

//   _BuildEmptyState({
//     Key? key,
//     required this.createBoard,
//     required this.formKey,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 600,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               message.first,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400,
//                 fontStyle: FontStyle.italic,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 40),
//             FormBuilder(
//               key: formKey,
//               child: FormBuilderTextField(
//                 name: 'title',
//                 decoration: const InputDecoration(
//                   labelText: 'Board Title',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(),
//                   FormBuilderValidators.minLength(3),
//                 ]),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.saveAndValidate()) {
//                     createBoard(formKey.currentState!.value);
//                   }
//                 },
//                 child: const Text('Create Board'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildCard(AppFlowyGroupItem item) {
//   if (item is TextItem) {
//     return RichTextCard(item: item.s);
//   }

//   if (item is RichTextItem) {
//     return RichTextCard(item: item.title);
//   }

//   throw UnimplementedError();
// }
