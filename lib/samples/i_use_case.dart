import 'package:hpf_cli/samples/sample.dart';

class IUseCaseSample extends Sample {
  IUseCaseSample() : super('lib/domain/use_cases/use_case.dart');

  String get import => '''
''';

  @override
  String get content => '''$import

abstract class UseCase<T, P> {
  Future<T> call({required P params});
}
''';
}
