import 'package:flutter/material.dart';

class AppNavigator {
  // Singleton class
  AppNavigator._();

  static final AppNavigator _instance = AppNavigator._();

  static AppNavigator get instance => _instance;

  Future<dynamic> push(
      {required BuildContext context, required Widget routePage}) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => routePage));
  }

  Future<dynamic> pushReplacement(
      {required BuildContext context, required Widget routePage}) async {
    return await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => routePage));
  }

  static void pop({required BuildContext context, dynamic args}) {
   return  Navigator.pop(context, args);
  }



  // static final GlobalKey<NavigatorState> navigatorKey =
  //     GlobalKey<NavigatorState>();

  // static Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
  //   return navigatorKey.currentState!
  //       .pushNamed(routeName, arguments: arguments);
  // }

  // static Future<dynamic> pushReplacementNamed(String routeName,
  //     {Object? arguments}) {
  //   return navigatorKey.currentState
  //           ?.pushReplacementNamed(routeName, arguments: arguments) ??
  //       Future.value();
  // }

  // static void pop() {
  //   return navigatorKey.currentState?.pop();
  // }

  // static void popUntil(String routeName) {
  //   return navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  // }
}
