import 'package:hpf_cli/common/pubspec/pubspec_utils.dart';
import 'package:hpf_cli/samples/sample.dart';
import 'package:recase/recase.dart';

class ScreenSample extends Sample {
  ScreenSample(
    String path,
    this._viewName,
  ) : super(path);

  final String _viewName;

  String get import => '''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:${PubspecUtils.projectName}/presentation/base/base_screen.dart';
import 'package:${PubspecUtils.projectName}/presentation/views/screens/$_viewName/${_viewName.snakeCase}_controller.dart';
import 'package:${PubspecUtils.projectName}/presentation/views/screens/$_viewName/${_viewName.snakeCase}_state.dart';
import 'package:${PubspecUtils.projectName}/presentation/view/widgets/app_app_bar.dart';
''';

  @override
  String get content => '''$import


class ${_viewName.pascalCase}Screen extends BaseScreen<${_viewName.pascalCase}Controller, ${_viewName.pascalCase}State> {
${_viewName.pascalCase}Screen({Key? key}) : super(key: key);

@override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'app_name'.tr()),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(),
      ),
    );
  }
}
''';
}
