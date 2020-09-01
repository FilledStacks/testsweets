/// Finds and returns the values passed into Keys
class KeyExtractor {
  const KeyExtractor();

  List<String> getKeysFromString(String value) {
    //
    RegExp keyRegex = new RegExp(
      r"(?:Key\('([0-9a-zA-z@]+)'\))",
      caseSensitive: false,
      multiLine: true,
    );

    var allMatchedKeys = keyRegex.allMatches(value);

    return allMatchedKeys
        .map((match) => match.group(0).substring(5, match.group(0).length - 2))
        .toList();
  }
}
