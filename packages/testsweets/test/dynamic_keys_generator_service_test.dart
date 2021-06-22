import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/dynamic_keys_generator_service.dart';

import 'helpers/test_consts.dart';
import 'helpers/test_helpers.dart';

void main() {
  group("DynamicKeysGeneratorService -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group(
        "generateAutomationKeysForDynamicKey(key, numberOfAutomationKeysToGenerate) -",
        () {
      test(
          "Given the key `orders_touchable_pending` and 1 numberOfAutomationKeysToGenerate, it should return an automation key with view=orders, type=touchable, and name=pending",
          () {
        final instance = DynamicKeysGeneratorServiceImplementation();
        final ret = instance.generateAutomationKeysForDynamicKey(
            key: "orders_touchable_pending",
            numberOfAutomationKeysToGenerate: 1);

        expect(ret, hasLength(1));
        expect(ret.first['view'], 'orders');
        expect(ret.first['type'], 'touchable');
        expect(ret.first['name'], 'pending');
      });

      test(
          "Given the key `orders_view` and 1 numberOfAutomationKeysToGenerate, it should return an automation key with view=orders, type=view, and name=orders",
          () {
        final instance = DynamicKeysGeneratorServiceImplementation();
        final ret = instance.generateAutomationKeysForDynamicKey(
            key: "orders_view", numberOfAutomationKeysToGenerate: 1);

        expect(ret, hasLength(1));
        expect(ret.first['view'], 'orders');
        expect(ret.first['type'], 'view');
        expect(ret.first['name'], 'orders');
      });
      test(
          "Given the key `orders_touchable_pending{index}Item` and 2 numberOfAutomationKeysToGenerate, it should return 2 automation keys both with view=orders, type=touchable but the first one have a name=pending0Item, and othe other have name=pending1Item",
          () {
        final instance = DynamicKeysGeneratorServiceImplementation();
        final ret = instance.generateAutomationKeysForDynamicKey(
            key: "orders_touchable_pending{index}Item",
            numberOfAutomationKeysToGenerate: 2);

        expect(ret, hasLength(2));
        expect(ret.first['view'], 'orders');
        expect(ret.last['view'], 'orders');

        expect(ret.first['type'], 'touchable');
        expect(ret.last['type'], 'touchable');

        expect(ret.first['name'], 'pending0Item');
        expect(ret.last['name'], 'pending1Item');
      });
    });

    final dynamicKeysFilePath = 'myApp\\dynamic_keys.json';
    // group("generateAutomationKeysFromDynamicKeysFile(String appPath) -", () {
    //   test(
    //       "Should use a default itemCount value of 10 if itemCount is not given for a given key",
    //       () {
    //     getAndRegisterFileSystemService(
    //       doesFileExist: true,
    //       readFileAsStringSyncResult: ksAppAutomationKeysForG,
    //     );
    //     final instance = DynamicKeysGeneratorServiceImplementation();
    //     final ret = instance
    //         .generateAutomationKeysFromDynamicKeysFile(ksAppAutomationKeysForG);

    //     expect(ret, hasLength(15));
    //     for (var automationKey in ret.take(10)) {
    //       expect(automationKey['view'], 'orders');
    //       expect(automationKey['type'], 'touchable');
    //       expect(automationKey['name'], 'pending');
    //     }
    //   });

    //   test(
    //       "Should use the given item count for a given key if the itemCount is given",
    //       () {
    //     final instance = DynamicKeysGeneratorServiceImplementation();
    //     final ret = instance
    //         .generateAutomationKeysFromDynamicKeysFile(dynamicKeysFilePath);

    //     expect(ret, hasLength(15));
    //     for (var automationKey in ret.reversed.take(5)) {
    //       expect(automationKey['view'], 'orders');
    //       expect(automationKey['type'], 'touchable');
    //       expect(automationKey['name'], 'ready');
    //     }
    //   });
    // });

    test(
        "Should return an empty list when the `dynamic_keys.json` file does NOT exist",
        () {
      getAndRegisterFileSystemService(doesFileExist: false);

      final instance = DynamicKeysGeneratorServiceImplementation();
      final ret = instance
          .generateAutomationKeysFromDynamicKeysFile(dynamicKeysFilePath);

      expect(ret, isEmpty);
    });
  });
}
