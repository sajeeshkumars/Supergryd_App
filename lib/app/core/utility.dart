class Utility {
  static countConverter(int count) {
    if ((count > 999) && count < 99999) {
      return '${(count / 1000).toStringAsFixed(1)} K';
    } else if (count > 99999 && count < 999999) {
      return '${(count / 1000).toStringAsFixed(0)} K';
    } else if (count > 999999 && count < 999999999) {
      return '${(count / 1000000).toStringAsFixed(1)} M';
    } else if (count > 999999999) {
      return '${(count / 1000000000).toStringAsFixed(1)} B';
    } else {
      return count.toString();
    }
  }
}
