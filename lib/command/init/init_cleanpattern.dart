import 'dart:io';

import 'package:hpf_cli/command/create/screen.dart';

import '../../common/pubspec/pubspec_utils.dart';
import '../../common/util/logger/log_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../../core/structure.dart';
import '../../functions/create/create_directory.dart';
import '../../functions/create/create_main.dart';
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
    Directory(Structure.replaceAsExpected(path: 'lib/data/')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/mappers/')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/local')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/remote')),
    Directory(Structure.replaceAsExpected(path: 'lib/data/repositories')),
    Directory(Structure.replaceAsExpected(path: 'lib/di/')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/entities/')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/enums')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/repositories')),
    Directory(Structure.replaceAsExpected(path: 'lib/domain/use_cases')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/base/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/resources/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/routers/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/views/')),
    Directory(Structure.replaceAsExpected(path: 'lib/utils/')),
  ];
  ProviderMainSample(isServer: isServerProject).create();
  await Future.wait([
    CreateScreenCommand().execute(),
  ]);
  createListDirectory(initialDirs);

  LogService.success(Translation(LocaleKeys.sucess_clean_Pattern_generated));
}
