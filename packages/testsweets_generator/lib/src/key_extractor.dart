/// Finds and returns the values passed into Keys
class KeyExtractor {
  const KeyExtractor();

  List<String> getKeysFromString(String value) {
    // remove all comments to filter out unwanted/commented out keys
    RegExp commentsRegex = RegExp(r'\/\*[\s\S]*?\*\/|\/\/.*');
    value = value.replaceAll(commentsRegex, '');

    RegExp keyRegex = new RegExp(
      r"(?:[\s=:]Key\('([0-9a-zA-z@]+)'\))",
      caseSensitive: true,
      multiLine: true,
    );

    var allMatchedKeys = keyRegex.allMatches(value);

    return allMatchedKeys.map((match) => match.group(1)).toSet().toList();
  }
}
