extension TextHelpers on String {
  // text length limit
  String limitLength(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}...';
    }
  }

  // to snake case
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).replaceAll(RegExp(r'^_'), '');
  }

  // to camel case
  String toCamelCase() {
    return toSnakeCase().replaceAllMapped(RegExp(r'(_\w)'), (match) {
      return match.group(0)!.toUpperCase().substring(1);
    });
  }

  // to pascal case
  String toPascalCase() {
    return toCamelCase().replaceFirstMapped(RegExp(r'\w'), (match) {
      return match.group(0)!.toUpperCase();
    });
  }

  // to folder name
  String toFolderName() {
    // if more than one word take the first word
    // captlize the first letter
    return split(' ').first.toPascalCase();
  }
}
