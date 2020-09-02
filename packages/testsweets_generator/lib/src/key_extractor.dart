/// Finds and returns the values passed into Keys
class KeyExtractor {
  const KeyExtractor();

  List<String> getKeysFromString(String value) {
    // regex needs improvement to ignore commented out keys
    RegExp keyRegex = new RegExp(
      r"(?:\sKey\('([0-9a-zA-z@]+)'\))",
      caseSensitive: false,
      multiLine: true,
    );

    var allMatchedKeys = keyRegex.allMatches(value);

    return allMatchedKeys.map((match) => match.group(1)).toList();
  }
}
