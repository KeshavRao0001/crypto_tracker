import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<MarketProvider>(
        create: (context) => MarketProvider(),
      ),
    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    );
  }
}

