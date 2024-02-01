import 'package:flutter/material.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';

class BuildSingleProjectCodeGen extends StatelessWidget {
  final String? localPath;
  const BuildSingleProjectCodeGen({
    super.key,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          var res = await CmdReadCreateDirServices().isFlutterPPProject(
            localPath!,
          );
          print(res);
        },
        child: const Text('Tasks'),
      ),
    );
  }
}
