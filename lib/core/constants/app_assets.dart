class AppAssets {
  static const String _base = 'assets';

  static String folder(String folderName, String fileName) {
    return '$_base/$folderName/$fileName';
  }

  static String onboarding(String fileName) {
    return folder('onboarding', fileName);
  }

  static String logo(String fileName) {
    return folder('logo', fileName);
  }
}
