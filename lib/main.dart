import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import './providers/theme_provider.dart';
import './pages/cryto_price_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(appThemeProvider);
    return MaterialApp(
      title: 'Crypto App',
      theme: isDark
          ? FlexThemeData.dark(
              scheme: FlexScheme.purpleM3,
              fontFamily: GoogleFonts.raleway().fontFamily,
            )
          : FlexThemeData.light(
              scheme: FlexScheme.purpleM3,
              fontFamily: GoogleFonts.raleway().fontFamily,
            ),
      // darkTheme: FlexThemeData.dark(scheme: FlexScheme.redM3),
      debugShowCheckedModeBanner: false,
      home: const PricesPage(),
    );
  }
}
