import 'package:build/build.dart';
import 'package:testsweets_generator/src/automation_key_generator.dart';

Builder automationKeyGenerator(BuilderOptions options) =>
    AutomationKeyGenerator(options);
