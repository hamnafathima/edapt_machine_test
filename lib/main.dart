import 'package:edapt_machine_test/provider/cart_provider.dart';
import 'package:edapt_machine_test/screens/match_style.dart';
import 'package:edapt_machine_test/provider/selected_provider.dart';
import 'package:edapt_machine_test/screens/selected_dress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MatchStyle(),
      ),
    );
  }
}
