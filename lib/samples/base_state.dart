import 'package:hpf_cli/samples/sample.dart';

class BaseStateSample extends Sample {
  BaseStateSample() : super('lib/presentation/base/base_state.dart');

  String get import => '''
import '../../domain/entities/error_entity.dart';
''';

  @override
  String get content => '''$import


abstract class BaseState {
  final ScreenStatus screenStatus;
  final bool processing;
  final ErrorEntity? errorEntity;

  BaseState(
      {required this.screenStatus, required this.processing, this.errorEntity});
}

enum ScreenStatus { uninitialized, loaded, failed }
''';
}
