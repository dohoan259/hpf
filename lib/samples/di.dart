import 'package:hpf_cli/samples/sample.dart';

class DISample extends Sample {
  DISample() : super('lib/di/di.dart');

  String get import => '''
  import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
''';

  @override
  String get content => '''$import

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async => getIt.init();
''';
}
