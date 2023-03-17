import 'package:hpf_cli/common/pubspec/pubspec_utils.dart';
import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

class UseCaseSample extends Sample {
  UseCaseSample(
    String path,
    this._fileName,
  ) : super(path);

  final String _fileName;

  String get import => '''
  import 'package:${PubspecUtils.projectName}/domain/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';
  ''';

  @override
  String get content => '''$import

@injectable
class ${_fileName.pascalCase}UseCase implements UseCase<int, Params> {
@override
  Future<int> call({required Params params}) async {
    // todo
    return 1;
  }

}

class Params {
  Params();
}
''';
}
