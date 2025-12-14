import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocaleState {
  final Locale locale;
  const LocaleState(this.locale);
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(Locale('en'))) {
    _detectDeviceLocale();
  }

  void _detectDeviceLocale() {
    final deviceLocale =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    if (deviceLocale == 'ar') {
      emit(const LocaleState(Locale('ar')));
    } else {
      // default to English
      emit(const LocaleState(Locale('en')));
    }
  }

  /// Optional: manual change
  void changeLocale(Locale locale) {
    emit(LocaleState(locale));
  }
}
