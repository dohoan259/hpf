import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import 'file_model.dart';

class Structure {
  static final Map<String, String> _paths = {
    'page': replaceAsExpected(path: 'lib/presentation/views/screens/'),
    'screen': replaceAsExpected(path: 'lib/presentation/views/screens/'),
    'widget': replaceAsExpected(path: 'lib/presentation/views/widgets/'),
    // 'controller': replaceAsExpected(path: 'lib/presentation//views/controller'),
    // 'state': replaceAsExpected(path: 'lib/presentation/state'),
    'route': replaceAsExpected(path: 'lib/presentation/routers/'),
    'use_case': replaceAsExpected(path: 'lib/domain/use_cases/'),
    'entity': replaceAsExpected(path: 'lib/domain/entities/'),
    'repository': replaceAsExpected(path: 'lib/domain/repositories'),
    'repository_impl': replaceAsExpected(path: 'lib/data/repositories'),
    'init': replaceAsExpected(path: 'lib/'),
  };

  static Map<String, String> get paths => _paths;

  static FileModel model(String? name, String command, bool wrapperFolder,
      {String? on, String? folderName}) {
    if (on != null && on != '') {
      on = replaceAsExpected(path: on).replaceAll('\\\\', '\\');
      var current = Directory('lib');
      final list = current.listSync(recursive: true, followLinks: false);
      final contains = list.firstWhere((element) {
        if (element is File) {
          return false;
        }
        return '${element.path}${p.separator}'.contains('$on${p.separator}');
      }, orElse: () {
        return list.firstWhere((element) {
          //Fix erro ao encontrar arquivo com nome
          if (element is File) {
            return false;
          }
          return element.path.contains(on!);
        }, orElse: () {
          throw Exception('Not found');
        });
      });

      return FileModel(
        name: name,
        path: Structure.getPathWithName(
          contains.path,
          ReCase(name!).snakeCase,
          createWithWrappedFolder: wrapperFolder,
          folderName: folderName,
        ),
        commandName: command,
      );
    }
    return FileModel(
      name: name,
      path: Structure.getPathWithName(
        _paths[command],
        ReCase(name!).snakeCase,
        createWithWrappedFolder: wrapperFolder,
        folderName: folderName,
      ),
      commandName: command,
    );
  }

  static String replaceAsExpected({required String path, String? replaceChar}) {
    if (path.contains('\\')) {
      if (Platform.isLinux || Platform.isMacOS) {
        return path.replaceAll('\\', '/');
      } else {
        return path;
      }
    } else if (path.contains('/')) {
      if (Platform.isWindows) {
        return path.replaceAll('/', '\\\\');
      } else {
        return path;
      }
    } else {
      return path;
    }
  }

  static String? getPathWithName(String? firstPath, String secondPath,
      {bool createWithWrappedFolder = false, required String? folderName}) {
    late String betweenPaths;
    if (Platform.isWindows) {
      betweenPaths = '\\\\';
    } else if (Platform.isMacOS || Platform.isLinux) {
      betweenPaths = '/';
    }
    if (betweenPaths.isNotEmpty) {
      if (createWithWrappedFolder) {
        return firstPath! +
            betweenPaths +
            (folderName ?? '') +
            betweenPaths +
            secondPath;
      } else {
        return firstPath! + betweenPaths + secondPath;
      }
    }
    return null;
  }

  static List<String> safeSplitPath(String path) {
    return path.replaceAll('\\', '/').split('/')
      ..removeWhere((element) => element.isEmpty);
  }

  static String pathToDirImport(String path) {
    var pathSplit = safeSplitPath(path)
      ..removeWhere((element) => element == '.' || element == 'lib');
    return pathSplit.join('/');
  }
}
