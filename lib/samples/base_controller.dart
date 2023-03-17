import 'package:hpf_cli/samples/sample.dart';

class BaseControllerSample extends Sample {
  BaseControllerSample() : super('lib/presentation/base/base_controller.dart');

  String get import => '''
import 'package:state_notifier/state_notifier.dart';

import '../../domain/entities/error_entity.dart';
import 'base_state.dart';
''';

  @override
  String get content => '''$import


abstract class BaseController<S extends BaseState> extends StateNotifier<S>
    with LocatorMixin {
  BaseController(S state) : super(state);

  Future<ErrorEntity?> loadData();

  Future<void> reload() async {}
}
''';
}
