import 'package:hpf_cli/command/args_mixin.dart';

abstract class Command with ArgsMixin {
  String get commandName;

  List<String> get alias => [];

  /// execute command
  Future<void> execute() async {
    // if (commandName != 'init' && commandName != 'project') {
    //   await ShellUtils.buildX();
    // }
  }

  /// children command
  List<Command> get children => [];
}
