import 'dart:io';

import 'package:hpf_cli/core/internationalization.dart';

import '../../../common/menu/menu.dart';
import '../../../common/util/logger/log_utils.dart';
import '../../../core/locales.g.dart';
import '../../../core/structure.dart';

Future<bool> createBaseScreen() async {
  var _fileModel = Structure.model('', 'presentation_base', false);

  var _main = File('${_fileModel.path}base_screen.dart');

  if (_main.existsSync()) {
    final menu = Menu([LocaleKeys.options_yes.tr, LocaleKeys.options_no.tr],
        title: LocaleKeys.ask_lib_not_empty.tr);
    final result = menu.choose();
    if (result.index == 1) {
      LogService.info(LocaleKeys.info_no_file_overwritten.tr);
      return false;
    }
    await Directory('lib/').delete(recursive: true);
  }
  return true;
}
