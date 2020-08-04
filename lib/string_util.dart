extension Capitalize on String {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}