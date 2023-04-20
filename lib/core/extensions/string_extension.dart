extension CapExtension on String {
  String get capitalizeFirstLetter {
    if (this != null && this.isNotEmpty) {
      return '${this[0]?.toUpperCase()}${this.substring(1).toLowerCase()}';
    }
    return '';
  }

  String get allInCaps {
    if (this != null && this.isNotEmpty) {
      return this.toUpperCase();
    }
    return '';
  }

  String get capitalizeFirstOfEach {
    if (this != null && this.isNotEmpty) {
      return this.split(" ")?.map((str) => str?.capitalizeFirstLetter)?.join(" ");
    }
    return '';
  }
}
