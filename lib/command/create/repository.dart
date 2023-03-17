import 'dart:io';

import 'package:hpf_cli/command/command.dart';
import 'package:hpf_cli/core/structure.dart';
import 'package:hpf_cli/functions/create/create_single_file.dart';
import 'package:hpf_cli/samples/repository.dart';
import 'package:hpf_cli/samples/repository_impl.dart';
import 'package:recase/recase.dart';

class CreateRepositoryCommand extends Command {
  @override
  String get commandName => 'repo';

  @override
  List<String> get alias => ['-rp'];

  @override
  Future<void> execute() async {
    var _fileModel = Structure.model(name, 'repository', true,
        on: onCommand, folderName: name);
    var pathSplit = Structure.safeSplitPath(_fileModel.path!);

    pathSplit.removeLast();
    var path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    Directory(path).createSync(recursive: true);
    final repoImplDir = Structure.paths['repository_impl']!;
    var extraFolder = true;
    handleFileCreate(
      name,
      'repository',
      null,
      false,
      RepositorySample(
        'repository',
        name,
      ),
      null,
    );
    handleFileCreate(
      name,
      'repository_impl',
      repoImplDir,
      extraFolder,
      RepositoryImplSample(
        '',
        name,
      ),
      null,
    );
    print('Success create repository ${name.pascalCase}');
  }
}
