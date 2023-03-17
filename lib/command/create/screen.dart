import 'dart:io';

import 'package:hpf_cli/command/command.dart';
import 'package:hpf_cli/core/structure.dart';
import 'package:hpf_cli/functions/create/create_single_file.dart';
import 'package:hpf_cli/samples/controller.dart';
import 'package:hpf_cli/samples/page.dart';
import 'package:hpf_cli/samples/state.dart';
import 'package:recase/recase.dart';

class CreateScreenCommand extends Command {
  @override
  String get commandName => 'screen';

  @override
  List<String> get alias => ['-sn'];

  @override
  Future<void> execute() async {
    var _fileModel =
        Structure.model(name, 'screen', true, on: onCommand, folderName: name);
    var pathSplit = Structure.safeSplitPath(_fileModel.path!);

    pathSplit.removeLast();
    var path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    Directory(path).createSync(recursive: true);
    var extraFolder = true;
    handleFileCreate(
      name,
      'state',
      path,
      extraFolder,
      StateSample(
        '',
        name,
      ),
      null,
    );
    handleFileCreate(
      name,
      'controller',
      path,
      extraFolder,
      ControllerSample(
        '',
        name,
      ),
      null,
    );
    handleFileCreate(
      name,
      'page',
      path,
      extraFolder,
      PageSample(
        '',
        name,
      ),
      null,
    );
    print('Success create screen ${name.pascalCase}');
  }
}
