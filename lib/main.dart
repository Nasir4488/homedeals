import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:homedeals/screens/auth/signUp.dart';
import 'package:homedeals/screens/home_screen/home_screen.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/elevated_button_style.dart';
import 'package:homedeals/utils/routes.dart';
import 'package:homedeals/utils/textTheams.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/property_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  // Registering the adapters
  Hive.registerAdapter(PropertyAdapter());
  Hive.registerAdapter(ListingAgentAdapter());
  await Hive.openBox('propertyBox');
  var userBox =await Hive.openBox("user");
  var storedUserName = userBox.get('userName');

  Widget intialScreen=storedUserName!=null?HomeScreen():SignUpScreen();
  runApp(MyApp(initialScreen: intialScreen));

}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key,required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        popupMenuTheme: PopupMenuThemeData(
          color: whiteColor, // Set background color to yellow
        ),
        elevatedButtonTheme: elevatedButton_style,
        textTheme: TextTheme(
          bodySmall: textsmall,
          bodyMedium: textmediam,
          bodyLarge: textlarge,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: initialScreen,
      getPages: allPages,
    );
  }
}
