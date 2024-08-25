
import 'package:flutter/material.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:604224460.
ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.transparent , elevation: 0 , iconTheme: IconThemeData(color: Colors.black) , titleTextStyle: const TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold)),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey[300]!,
    primary: Colors.grey[500]!,
    secondary: Colors.grey[600]!,
    
  ),
  );
