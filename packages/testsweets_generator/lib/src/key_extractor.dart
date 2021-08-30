/// Finds and returns the values passed into Keys
class KeyExtractor {
  const KeyExtractor();

  List<String> getKeysFromString(String value) {
    // remove all comments to filter out unwanted/commented out keys
    RegExp commentsRegex = RegExp(r'\/\*[\s\S]*?\*\/|\/\/.*');
    value = value.replaceAll(commentsRegex, '');
    print(value);
    RegExp keyRegex = new RegExp(
      r"""(?:[\s=:]Key\([\s\n]*['|"]([0-9a-zA-z@]+)['|"]\))""",
      caseSensitive: true,
      multiLine: true,
    );

    var allMatchedKeys = keyRegex.allMatches(value);

    final keyValues =
        allMatchedKeys.map((match) => match.group(1)).toSet().toList();
    final out = <String>[];
    for (var keyValue in keyValues)
      if (keyValue != null && keyValue.split('_').length > 1) out.add(keyValue);

    return out;
  }
}
