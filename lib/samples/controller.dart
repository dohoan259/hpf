import 'package:hpf_cli/common/pubspec/pubspec_utils.dart';
import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

class ControllerSample extends Sample {
  ControllerSample(
    String path,
    this._fileName,
  ) : super(path);

  final String _fileName;

  String get import => '''import 'package:injectable/injectable.dart';
import 'package:${PubspecUtils.projectName}/domain/entities/error_entity.dart';
import 'package:${PubspecUtils.projectName}/presentation/base/base_controller.dart';
import 'package:${PubspecUtils.projectName}/presentation/base/base_state.dart';
import '${_fileName.snakeCase}_state.dart';

  ''';

  @override
  String get content => '''$import

@injectable
class ${_fileName.pascalCase}Controller extends BaseController<${_fileName.pascalCase}State> {
  ${_fileName.pascalCase}Controller() : super(${_fileName.pascalCase}State());

  @override
  Future<ErrorEntity?> loadData() async {
    state = state.copyWith(screenStatus: ScreenStatus.loaded);
    return null;
  }
}
''';
}
