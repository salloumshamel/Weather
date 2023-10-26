import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/theme_provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().theme.backgroundColor,
      body: Center(
        child: Image.asset(
          'images/icons/cloud_sun.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
