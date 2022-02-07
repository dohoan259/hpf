import 'dart:io';

import 'package:hpf_cli/common/pubspec/pubdev_utils.dart';
import 'package:hpf_cli/common/pubspec/yaml_to.string.dart';
import 'package:hpf_cli/common/shell/shell_utils.dart';
import 'package:pubspec/pubspec.dart';
import 'package:version/version.dart' as v;

// ignore: avoid_classes_with_only_static_members
class PubspecUtils {
  static final _pubspecFile = File('pubspec.yaml');

  static PubSpec get pubSpec =>
      PubSpec.fromYamlString(_pubspecFile.readAsStringSync());

  /// separtor
  static final _mapSep = _PubValue<String>(() {
    var yaml = pubSpec.unParsedYaml!;
    if (yaml.containsKey('get_cli')) {
      if ((yaml['get_cli'] as Map).containsKey('separator')) {
        return (yaml['get_cli']['separator'] as String?) ?? '';
      }
    }

    return '';
  });

  static String? get separatorFileType => _mapSep.value;

  static final _mapName = _PubValue<String>(() => pubSpec.name?.trim() ?? '');

  static String? get projectName => _mapName.value;

  static final _extraFolder = _PubValue<bool?>(
    () {
      try {
        var yaml = pubSpec.unParsedYaml!;
        if (yaml.containsKey('get_cli')) {
          if ((yaml['get_cli'] as Map).containsKey('sub_folder')) {
            return (yaml['get_cli']['sub_folder'] as bool?);
          }
        }
      } on Exception catch (_) {}
      // retorno nulo está sendo tratado
      // ignore: avoid_returning_null
      return null;
    },
  );

  static bool? get extraFolder => _extraFolder.value;

  static Future<bool> addDependencies(String package,
      {String? version, bool isDev = false, bool runPubGet = true}) async {
    var pubSpec = PubSpec.fromYamlString(_pubspecFile.readAsStringSync());

    version = version == null || version.isEmpty
        ? await PubDevApi.getLatestVersionFromPackage(package)
        : '^$version';
    if (version == null) return false;
    if (isDev) {
      pubSpec.devDependencies[package] = HostedReference.fromJson(version);
    } else {
      pubSpec.dependencies[package] = HostedReference.fromJson(version);
    }

    _savePub(pubSpec);
    if (runPubGet) await ShellUtils.pubGet();
    return true;
  }

  static void removeDependencies(String package, {bool logger = true}) {
    print('Removing package: "$package"');

    if (containsPackage(package)) {
      var dependencies = pubSpec.dependencies;
      var devDependencies = pubSpec.devDependencies;

      dependencies.removeWhere((key, value) => key == package);
      devDependencies.removeWhere((key, value) => key == package);
      var newPub = pubSpec.copy(
        devDependencies: devDependencies,
        dependencies: dependencies,
      );
      _savePub(newPub);
    }
  }

  static bool containsPackage(String package, [bool isDev = false]) {
    var dependencies = isDev ? pubSpec.devDependencies : pubSpec.dependencies;
    return dependencies.containsKey(package.trim());
  }

  static bool get nullSafeSupport => !pubSpec.environment!.sdkConstraint!
      .allowsAny(HostedReference.fromJson('<2.12.0').versionConstraint);

  /// make sure it is a get_server project
  static bool get isServerProject {
    return containsPackage('get_server');
  }

  static String get getPackageImport => !isServerProject
      ? "import 'package:get/get.dart';"
      : "import 'package:get_server/get_server.dart';";

  static v.Version? getPackageVersion(String package) {
    if (containsPackage(package)) {
      var version = pubSpec.allDependencies[package]!;
      try {
        final json = version.toJson();
        if (json is String) {
          return v.Version.parse(json);
        }
        return null;
      } on FormatException catch (_) {
        return null;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      throw Exception(package);
    }
  }

  static void _savePub(PubSpec pub) {
    var value = CliYamlToString().toYamlString(pub.toJson());
    _pubspecFile.writeAsStringSync(value);
  }
}

/// avoids multiple reads in one file
class _PubValue<T> {
  final T Function() _setValue;
  bool _isChecked = false;
  T? _value;

  /// takes the value of the file,
  /// if not already called it will call the first time
  T? get value {
    if (!_isChecked) {
      _isChecked = true;
      _value = _setValue.call();
    }
    return _value;
  }

  _PubValue(this._setValue);
}
