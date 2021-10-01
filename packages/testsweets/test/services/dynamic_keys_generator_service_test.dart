import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/dynamic_keys_generator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group("DynamicKeysGeneratorService -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group("generateAutomationKeysForDynamicKey-", () {
      test(
          "Given the key `orders_touchable_pending` and 1 numberOfAutomationKeysToGenerate, it should return 1 key order_touchable_pending",
          () {
        final instance = DynamicKeysGenerator();
        final result = instance.generateAutomationKeysForDynamicKey(
            key: "orders_touchable_pending",
            numberOfAutomationKeysToGenerate: 1);

        expect(result, hasLength(1));
        expect(result.first, 'orders_touchable_pending');
      });

      test(
          "Given the key `orders_view` and 1 numberOfAutomationKeysToGenerate, it should return orders_view_orders",
          () {
        final instance = DynamicKeysGenerator();
        final result = instance.generateAutomationKeysForDynamicKey(
          key: "orders_view",
          numberOfAutomationKeysToGenerate: 1,
        );

        expect(result, hasLength(1));
        expect(result.first, 'orders_view_orders');
      });
      test(
          "Given the key `orders_touchable_pending{index}Item` and 2 numberOfAutomationKeysToGenerate, it should return orders_touchable_pending0Item and orders_touchable_pending1Item",
          () {
        final instance = DynamicKeysGenerator();
        final results = instance.generateAutomationKeysForDynamicKey(
            key: "orders_touchable_pending{index}Item",
            numberOfAutomationKeysToGenerate: 2);

        expect(results.first, 'orders_touchable_pending0Item');
        expect(results.last, 'orders_touchable_pending1Item');
      });
    });

    final dynamicKeysFilePath = 'myApp\\dynamic_keys.json';

    test(
        "Should return an empty list when the `dynamic_keys.json` file does NOT exist",
        () {
      getAndRegisterFileSystemService(doesFileExist: false);

      final instance = DynamicKeysGenerator();
      final result = instance
          .generateAutomationKeysFromDynamicKeysFile(dynamicKeysFilePath);

      expect(result, isEmpty);
    });
  });
}
