import 'package:hpf_cli/core/generator.dart';

void main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();

  final command = HpfCli(arguments).findCommand();
  await command.execute();
  // await ShellUtils.buildX();

  time.stop();
}
