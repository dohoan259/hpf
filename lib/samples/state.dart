import 'package:hpf_cli/common/pubspec/pubspec_utils.dart';
import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

class StateSample extends Sample {
  StateSample(
    String path,
    this._fileName,
  ) : super(path);

  final String _fileName;

  String get import =>
      '''import 'package:${PubspecUtils.projectName}/presentation/base/base_state.dart';
  
  import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:${PubspecUtils.projectName}/presentation/base/base_state.dart';
import 'package:${PubspecUtils.projectName}/presentation/base/screen_status.dart';

part '${_fileName.snakeCase}_state.freezed.dart';

  ''';

  @override
  String get content => '''$import

class ${_fileName.pascalCase}Controller extends BaseState with _\$${_fileName.pascalCase}State {
  factory ${_fileName.pascalCase}State({
    @Default(ScreenStatus.Uninitialized) ScreenStatus status,
    @Default(false) bool processing,
  }) = _${_fileName.pascalCase}State;
}
''';
}
