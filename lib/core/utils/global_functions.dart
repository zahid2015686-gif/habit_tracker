import 'package:google_fonts/google_fonts.dart';

class GlobalFunctions {
  static Future<void> preloadFonts() async {
    await Future.wait([
      GoogleFonts.pendingFonts([GoogleFonts.poppins()]),
    ]);
  }
}