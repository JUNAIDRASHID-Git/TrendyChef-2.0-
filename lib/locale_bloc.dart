import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(const Locale('en')));

  void changeLocale(Locale locale) {
    emit(LocaleState(locale));
  }
}
