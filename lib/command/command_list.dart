import 'command.dart';
import 'command_parent.dart';
import 'create/page.dart';

final List<Command> commands = [
  CommandParent(
    'create',
    [
      // CreateControllerCommand(),
      CreatePageCommand(),
      // CreateProjectCommand(),
      // CreateProviderCommand(),
      // CreateScreenCommand(),
      // CreateViewCommand()
    ],
    ['-c'],
  ),
];
