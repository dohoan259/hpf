import 'package:process_run/shell_run.dart';

class ShellUtils {
  static Future<void> pubGet() async {
    print('Running `flutter pub get` …');
    await run('flutter pub get', verbose: true);
  }

  static Future<void> activatedNullSafe() async {
    await pubGet();
    await run('dart migrate --apply-changes --skip-import-check',
        verbose: true);
  }

  static Future<void> flutterCreate(
    String path,
    String? org,
    String iosLang,
    String androidLang,
  ) async {
    print('Running `flutter create $path` …');

    await run(
        'flutter create --no-pub -i $iosLang -a $androidLang --org $org'
        ' "$path"',
        verbose: true);
  }

  static Future<void> buildX() async {
    print('Running `flutter pub get` …');
    await run(
        'flutter packages pub run build_runner build --delete-conflicting-outputs',
        verbose: true);
  }

  // static Future<void> update(
  //     [bool isGit = false, bool forceUpdate = false]) async {
  //   isGit = GetCli.arguments.contains('--git');
  //   forceUpdate = GetCli.arguments.contains('-f');
  //   if (!isGit && !forceUpdate) {
  //     var versionInPubDev =
  //     await PubDevApi.getLatestVersionFromPackage('get_cli');

  // var versionInstalled = await PubspecLock.getVersionCli(disableLog: true);

  // if (versionInstalled == versionInPubDev) {
  //   return print('already installed');
  // }
  //   }
  //
  //   print('Upgrading get_cli …');
  //
  //   try {
  //     if (Platform.script.path.contains('flutter')) {
  //       if (isGit) {
  //         await run(
  //             'flutter pub global activate -sgit https://github.com/jonataslaw/get_cli/',
  //             verbose: true);
  //       } else {
  //         await run('flutter pub global activate get_cli', verbose: true);
  //       }
  //     } else {
  //       if (isGit) {
  //         await run(
  //             'flutter pub global activate -sgit https://github.com/jonataslaw/get_cli/',
  //             verbose: true);
  //       } else {
  //         await run('flutter pub global activate get_cli', verbose: true);
  //       }
  //     }
  //     return LogService.success(LocaleKeys.sucess_update_cli.tr);
  //   } on Exception catch (err) {
  //     print(err.toString());
  //     return LogService.error(LocaleKeys.error_update_cli.tr);
  //   }
  // }
}
