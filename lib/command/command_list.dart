import 'command.dart';
import 'command_parent.dart';
import 'create/page.dart';
import 'create/project.dart';
import 'create/screen.dart';

final List<Command> commands = [
  CommandParent(
    'create',
    [
      // CreateControllerCommand(),
      CreatePageCommand(),
      CreateScreenCommand(),
      CreateProjectCommand(),
      // CreateProviderCommand(),
      // CreateScreenCommand(),
      // CreateViewCommand()
    ],
    ['-c'],
  ),
];
