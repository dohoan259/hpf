import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

import '../common/pubspec/pubspec_utils.dart';

class RouterSample extends Sample {
  RouterSample() : super('lib/presentation/routers/routers.dart');

  String get import => '''
import 'package:auto_route/annotations.dart';
import 'package:${PubspecUtils.projectName}/presentation/views/screens/${PubspecUtils.projectName}/${PubspecUtils.projectName}_screen.dart';
''';

  @override
  String get content => '''$import


/// The route configuration.
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
  AutoRoute(page: ${PubspecUtils.projectName?.pascalCase}Screen, initial: true),
  ],
)
class \$AppRouter {}
''';
}
