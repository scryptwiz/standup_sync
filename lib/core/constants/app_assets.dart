class AppAssets {
  static const String _base = 'assets';

  static String folder(String folderName, String fileName) {
    return '$_base/$folderName/$fileName';
  }
}
