import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:hpf_cli/core/internationalization.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import '../../common/menu/menu.dart';
import '../../common/pubspec/pubspec_utils.dart';
import '../../common/shell/shell_utils.dart';
import '../../core/locales.g.dart';
import '../../core/structure.dart';
import '../../samples/analysis_options.dart';
import '../command.dart';
import '../init/init.dart';

class CreateProjectCommand extends Command {
  @override
  String get commandName => 'project';

  @override
  Future<void> execute() async {
    String? nameProject = name;
    if (name == '.') {
      final dialog = CLI_Dialog(questions: [
        [LocaleKeys.ask_name_to_project.tr, 'name']
      ]);
      nameProject = dialog.ask()['name'] as String?;
    }

    var path = Structure.replaceAsExpected(
        path: Directory.current.path + p.separator + nameProject!.snakeCase);
    await Directory(path).create(recursive: true);

    Directory.current = path;
    final dialog = CLI_Dialog(questions: [
      [
        '${LocaleKeys.ask_company_domain.tr} \x1B[33m '
            '${LocaleKeys.example.tr} com.yourcompany \x1B[0m',
        'org'
      ]
    ]);

    var org = dialog.ask()['org'] as String?;

    final iosLangMenu =
        Menu(['Swift', 'Objective-C'], title: LocaleKeys.ask_ios_lang.tr);
    final iosResult = iosLangMenu.choose();

    var iosLang = iosResult.index == 0 ? 'swift' : 'objc';

    final androidLangMenu =
        Menu(['Kotlin', 'Java'], title: LocaleKeys.ask_android_lang.tr);
    final androidResult = androidLangMenu.choose();

    var androidLang = androidResult.index == 0 ? 'kotlin' : 'java';

    final linterMenu = Menu([
      'no',
      'Pedantic [Deprecated]',
      'Effective Dart [Deprecated]',
      'Dart Recommended',
    ], title: LocaleKeys.ask_use_linter.tr);
    final linterResult = linterMenu.choose();

    await ShellUtils.flutterCreate(path, org, iosLang, androidLang);

    File('test/widget_test.dart').writeAsStringSync('');

    switch (linterResult.index) {
      case 1:
        await PubspecUtils.addDependencies('pedantic',
            isDev: true, runPubGet: false);
        AnalysisOptionsSample(
                include: 'include: package:pedantic/analysis_options.yaml')
            .create();
        break;
      case 2:
        await PubspecUtils.addDependencies('effective_dart',
            isDev: true, runPubGet: false);
        AnalysisOptionsSample(
            include: 'include: package:effective_dart/analysis_options.yaml');
        break;
      case 3:
        await PubspecUtils.addDependencies('lints',
            isDev: true, runPubGet: true);
        AnalysisOptionsSample(
                include: 'include: package:lints/recommended.yaml')
            .create();
        break;
      default:
        AnalysisOptionsSample().create();
    }

    // build runner
    await PubspecUtils.addDependencies('build_runner',
        isDev: true, runPubGet: false);

    // localization
    await PubspecUtils.addDependencies('easy_localization',
        isDev: false, runPubGet: false, version: '3.0.1');

    // DI
    await PubspecUtils.addDependencies('get_it',
        isDev: false, runPubGet: false, version: '7.2.0');
    await PubspecUtils.addDependencies('injectable',
        isDev: false, runPubGet: false, version: '2.1.0');
    await PubspecUtils.addDependencies('injectable_generator',
        isDev: true, runPubGet: false, version: '2.1.4');

    // Provider
    await PubspecUtils.addDependencies('provider',
        isDev: false, runPubGet: false, version: '6.0.5');
    await PubspecUtils.addDependencies('state_notifier',
        isDev: false, runPubGet: false, version: '0.7.2+1');
    await PubspecUtils.addDependencies('flutter_state_notifier',
        isDev: false, runPubGet: false, version: '0.7.3');

    // router
    await PubspecUtils.addDependencies('auto_route',
        isDev: false, runPubGet: false, version: '5.0.4');
    await PubspecUtils.addDependencies('auto_route_generator',
        isDev: true, runPubGet: false, version: '5.0.3');

    // freezed
    await PubspecUtils.addDependencies('freezed_annotation',
        isDev: false, runPubGet: false, version: '2.2.0');
    await PubspecUtils.addDependencies('freezed',
        isDev: true, runPubGet: false, version: '2.3.2');

    // create

    await InitCommand().execute();
  }

  @override
  String? get hint => LocaleKeys.hint_create_project.tr;

  @override
  bool validate() {
    return true;
  }

  @override
  String get codeSample => 'get create project';

  @override
  int get maxParameters => 0;
}
