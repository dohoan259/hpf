import 'package:hpf_cli/samples/sample.dart';

class UninitializedWidgetSample extends Sample {
  UninitializedWidgetSample()
      : super('lib/presentation/views/widgets/uninitialized_widget.dart');

  String get import => '''
import 'package:flutter/material.dart';
''';

  @override
  String get content => '''$import


class UninitializedWidget extends StatelessWidget {
  const UninitializedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
''';
}
