import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;

  ThemeCubit(this.prefs) : super(ThemeMode.light) {
    final dark = prefs.getBool("dark") ?? false;
    emit(dark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggle() {
    final newTheme =
    state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    prefs.setBool("dark", newTheme == ThemeMode.dark);
    emit(newTheme);
  }
}