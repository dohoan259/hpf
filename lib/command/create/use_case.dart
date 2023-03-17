import 'dart:io';

import 'package:hpf_cli/command/command.dart';
import 'package:hpf_cli/core/structure.dart';
import 'package:hpf_cli/functions/create/create_single_file.dart';
import 'package:recase/recase.dart';

import '../../samples/use_case.dart';

class CreateUseCaseCommand extends Command {
  @override
  String get commandName => 'use_case';

  @override
  List<String> get alias => ['-uc'];

  @override
  Future<void> execute() async {
    var _fileModel = Structure.model(name, 'use_case', true,
        on: onCommand, folderName: name);
    var pathSplit = Structure.safeSplitPath(_fileModel.path!);

    pathSplit.removeLast();
    var path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    Directory(path).createSync(recursive: true);
    var extraFolder = true;
    handleFileCreate(
      name,
      'use_case',
      path,
      extraFolder,
      UseCaseSample(
        'use_case',
        name,
      ),
      null,
    );
    print('Success create use case ${name.pascalCase}');
  }
}
