import 'package:hpf_cli/common/pubspec/pubspec_utils.dart';
import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

class RepositoryImplSample extends Sample {
  RepositoryImplSample(
    String path,
    this._fileName,
  ) : super(path);

  final String _fileName;

  String get import => '''
  import 'package:injectable/injectable.dart';
  import 'package:${PubspecUtils.projectName}/domain/repositories/${_fileName.snakeCase}_repository.dart';
  ''';

  @override
  String get content => '''$import

@Injectable(as: ${_fileName.pascalCase}Repository)
class ${_fileName.pascalCase}RepositoryImpl implements ${_fileName.pascalCase}Repository {
}
''';
}
