import 'dart:io';

import 'package:hpf_cli/common/pubspec/pubspec_utils.dart';
import 'package:hpf_cli/core/structure.dart';
import 'package:hpf_cli/functions/file/import_sort.dart';
import 'package:hpf_cli/samples/sample.dart';

File handleFileCreate(String name, String command, String on, bool extraFolder,
    Sample sample, String? folderName,
    [String sep = '_']) {
  folderName = folderName;
  /* if (folderName.isNotEmpty) {
    extraFolder = PubspecUtils.extraFolder ?? extraFolder;
  } */

  final fileModel = Structure.model(name, command, extraFolder,
      on: on, folderName: folderName);
  var path = '${fileModel.path}$sep${fileModel.commandName}.dart';
  sample.path = path;

  return sample.create();
}

/// Create or edit the contents of a file
File writeFile(String path, String content,
    {bool overwrite = false,
    bool skipFormatter = false,
    bool skipRename = false,
    bool useRelativeImport = false}) {
  var _file = File(Structure.replaceAsExpected(path: path));

  if (!_file.existsSync() || overwrite) {
    if (!skipFormatter) {
      if (path.endsWith('.dart')) {
        try {
          content = sortImports(
            content,
            renameImport: !skipRename,
            filePath: path,
            useRelative: useRelativeImport,
          );
        } on Exception catch (_) {
          if (_file.existsSync()) {
            print('file not found ${_file.path}');
          }
          rethrow;
        }
      }
    }
    if (!skipRename && _file.path != 'pubspec.yaml') {
      var separatorFileType = PubspecUtils.separatorFileType!;
      if (separatorFileType.isNotEmpty) {
        _file = _file.existsSync()
            ? _file = _file
                .renameSync(replacePathTypeSeparator(path, separatorFileType))
            : File(replacePathTypeSeparator(path, separatorFileType));
      }
    }

    _file.createSync(recursive: true);
    _file.writeAsStringSync(content);
  }
  return _file;
}

/// Replace the file name separator
String replacePathTypeSeparator(String path, String separator) {
  if (separator.isNotEmpty) {
    var index = path.indexOf(RegExp(r'controller.dart|model.dart|provider.dart|'
        'binding.dart|view.dart|screen.dart|widget.dart|repository.dart'));
    if (index != -1) {
      var chars = path.split('');
      index--;
      chars.removeAt(index);
      if (separator.length > 1) {
        chars.insert(index, separator[0]);
      } else {
        chars.insert(index, separator);
      }
      return chars.join();
    }
  }

  return path;
}
