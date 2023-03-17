import 'dart:io';

import 'package:hpf_cli/command/create/screen.dart';
import 'package:hpf_cli/samples/base_screen.dart';
import 'package:hpf_cli/samples/di.dart';
import 'package:hpf_cli/samples/error_dialog.dart';
import 'package:hpf_cli/samples/error_entity.dart';
import 'package:hpf_cli/samples/loading_dialog.dart';
import 'package:hpf_cli/samples/routers.dart';
import 'package:hpf_cli/samples/uninitialized_widget.dart';
import 'package:hpf_cli/samples/use_case.dart';

import '../../common/pubspec/pubspec_utils.dart';
import '../../common/util/logger/log_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../../core/structure.dart';
import '../../functions/create/create_directory.dart';
import '../../functions/create/create_main.dart';
import '../../samples/base_controller.dart';
import '../../samples/base_state.dart';
import '../../samples/provider_main.dart';
import '../install/install_get.dart';

Future<void> createCleanPattern() async {
  var canContinue = await createMain();
  if (!canContinue) return;

  var isServerProject = PubspecUtils.isServerProject;
  if (!isServerProject) {
    await installGet();
  }
  var initialDirs = [
    // data
    Directory(Structure.replaceAsExpected(path: 'lib/data/')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/mappers/')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/local')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/remote')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/repositories')),
    // di
    Directory(Structure.replaceAsExpected(path: 'lib/di/')),
    // domain
    Directory(Structure.replaceAsExpected(path: 'lib/domain/')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/entities/')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/enums')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/repositories')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/use_cases')),
    // presentation
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/base/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/resources/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/routers/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/views/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/presentation/views/screens/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/presentation/views/dialogs/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/presentation/views/widgets/')),
    Directory(Structure.replaceAsExpected(path: 'lib/utils/')),
  ];
  // init main.dart
  ProviderMainSample(isServer: isServerProject).create();
  // presentation
  BaseScreenSample().create();
  BaseControllerSample().create();
  BaseStateSample().create();
  UninitializedWidgetSample().create();
  ErrorDialogSample().create();
  LoadingDialogSample().create();
  RouterSample().create();
  // domain
  UseCaseSample().create();
  ErrorEntitySample().create();
  // data
  // ErrorHandlerSample().create();
  // di
  DISample().create();

  // init sample screen
  await Future.wait([
    CreateScreenCommand().execute(),
  ]);
  createListDirectory(initialDirs);

  // await ShellUtils.pubGet();
  // await ShellUtils.buildX();

  LogService.success(Translation(LocaleKeys.sucess_clean_Pattern_generated));
}
