class Utils {
  static int clamp(int value, int min, int max) {
    if (value > max) return max;
    if (value < min) return min;

    return value;
  }

  static int abs(int value) {
    value = (value < 0) ? value * -1 : value;

    return value;
  }
}
