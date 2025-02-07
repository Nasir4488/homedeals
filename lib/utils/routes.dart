import 'package:get/get.dart';
import 'package:homedeals/screens/advance_filter_screen/advancefilterScreen.dart';
import 'package:homedeals/screens/auth/login.dart';
import 'package:homedeals/screens/auth/signUp.dart';
import 'package:homedeals/screens/createlisting_screen/create_listing.dart';
import 'package:homedeals/screens/profile_screen/profileScreen.dart';
import 'package:homedeals/screens/short_filter/ShortFiltersScreen.dart';
import 'package:homedeals/screens/single_property/single_property_screen.dart';
import '../models/property_model.dart';
import '../screens/home_screen/home_screen.dart';

class AllRoutes {
  static const String homePage = "/home";
  static const String loginPage = "/login";
  static const String createListingPage = "/createListing";
  static const String advancefilter = "/advancefilter";
  static const String profilescreen = "/profilescreen";
  static const String signupScreen = "/signUp";
  static const String singlePropertyScreen = "/singlePropertyScreen";
  static const String shortFilterScreen = "/shortFilterScreen";
}

List<GetPage> allPages = [
  GetPage(name: AllRoutes.homePage, page: () => const HomeScreen()),
  GetPage(name: AllRoutes.createListingPage, page: () => const CreateListing()),
  GetPage(name: AllRoutes.profilescreen, page: () => const ProfileScreen()),
  GetPage(name: AllRoutes.loginPage, page: () => const LoginScreen()),
  GetPage(name: AllRoutes.signupScreen, page: () => const SignUpScreen()),
  GetPage(name: AllRoutes.advancefilter, page: ()=>const AdvanceFilter(),parameters: {}),
  GetPage(name: AllRoutes.singlePropertyScreen, page: () => SinglePropertyScreen(),),
  GetPage(name: AllRoutes.shortFilterScreen, page: () => Shortfiltersscreen()),
];
