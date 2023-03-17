import 'command.dart';
import 'command_parent.dart';
import 'create/page.dart';
import 'create/project.dart';
import 'create/repository.dart';
import 'create/screen.dart';
import 'create/use_case.dart';

final List<Command> commands = [
  CommandParent(
    'create',
    [
      CreateProjectCommand(),
      // CreateControllerCommand(),
      CreatePageCommand(),
      CreateScreenCommand(),
      CreateUseCaseCommand(),
      CreateRepositoryCommand(),
      // CreateProviderCommand(),
      // CreateViewCommand()
    ],
    ['-c'],
  ),
];
