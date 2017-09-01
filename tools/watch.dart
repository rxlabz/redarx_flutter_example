import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';

Future main(List<String> args) async {
  watch(
    new PhaseGroup.singleAction(new PartBuilder([new BuiltValueGenerator()]),
      new InputSet('clapp_data', const ['lib/src/values/*.dart'])),
    deleteFilesByDefault: true);
}