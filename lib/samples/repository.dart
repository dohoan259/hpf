import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

class RepositorySample extends Sample {
  RepositorySample(
    String path,
    this._fileName,
  ) : super(path);

  final String _fileName;

  String get import => '''
  ''';

  @override
  String get content => '''$import

abstract class ${_fileName.pascalCase}Repository {
}
''';
}
