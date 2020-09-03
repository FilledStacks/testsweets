import 'package:test/test.dart';
import 'package:testsweets_generator/src/key_extractor.dart';

import 'setup/test_data.dart';

void main() {
  group('KeyExtractorTest -', () {
    group('getKeysFromString -', () {
      test('When called with TWO keys in string, should return both key values',
          () {
        var extractor = KeyExtractor();
        var keys = extractor.getKeysFromString(CodeWithTwoKeys);
        final keysInCodeWithTwoKeys = ['text_counter', 'touchable_counter'];
        expect(keys, keysInCodeWithTwoKeys);
      });

      test('When called with NO keys in string, should return empty list', () {
        var extractor = KeyExtractor();
        var keys = extractor.getKeysFromString(CodeWithNoKeys);
        final keysInCodeWithNoKeys = [];
        expect(keys, keysInCodeWithNoKeys);
      });

      test(
          'When called with COMMENTED keys in string, should not return those keys',
          () {
        var extractor = KeyExtractor();
        var keys = extractor.getKeysFromString(CodeWithCommentedKeys);
        final keysInCodeWithTwoKeys = ['text_counter', 'touchable_counter'];
        expect(keys, keysInCodeWithTwoKeys);
      });
    });
  });
}
