import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.'
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Onboarding Screen',
        home: OnboardingScreen(),
        debugShowCheckedModeBanner: false,
        // home: Wrapper(),
      );
  }
}
