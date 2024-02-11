extension IntHelpers on int {
  // from kb to mb or gb or tb
  String toFileSize() {
    // file stored in kb
    // calculate all other file size
    if (this < 1024) {
      return '$this KB';
    } else if (this < 1048576) {
      return '${(this / 1024).toStringAsFixed(1)} MB';
    } else if (this < 1073741824) {
      return '${(this / 1048576).toStringAsFixed(1)} GB';
    } else {
      return '${(this / 1073741824).toStringAsFixed(2)} TB';
    }
  }
}
