import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/screens/Home/screen.dart';
import 'package:weather/screens/Loading/screen.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<ApiProvider>().isLoading;
    return isLoading ? LoadingScreen() : HomePage();
  }
}
