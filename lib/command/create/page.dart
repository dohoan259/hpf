import 'dart:io';

import 'package:hpf_cli/command/command.dart';
import 'package:hpf_cli/core/structure.dart';
import 'package:hpf_cli/functions/create/create_single_file.dart';
import 'package:hpf_cli/samples/controller.dart';
import 'package:hpf_cli/samples/page.dart';
import 'package:hpf_cli/samples/state.dart';
import 'package:recase/recase.dart';

class CreatePageCommand extends Command {
  @override
  String get commandName => 'page';

  @override
  List<String> get alias => ['-p'];

  @override
  Future<void> execute() async {
    var _fileModel =
        Structure.model(name, 'page', true, on: onCommand, folderName: name);
    var pathSplit = Structure.safeSplitPath(_fileModel.path!);

    pathSplit.removeLast();
    var path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    final stateDir = Structure.paths['state']!;
    final controllerDir = Structure.paths['controller']!;
    Directory(path).createSync(recursive: true);
    Directory(stateDir).createSync(recursive: true);
    Directory(controllerDir).createSync(recursive: true);
    var extraFolder = true;

    handleFileCreate(
      name,
      'state',
      stateDir,
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
      controllerDir,
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
    print('Success create page ${name.pascalCase}');
  }
}
