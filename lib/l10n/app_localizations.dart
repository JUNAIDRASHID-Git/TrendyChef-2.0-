import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcometotrendychef.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Trendy Chef'**
  String get welcometotrendychef;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @hala.
  ///
  /// In en, this message translates to:
  /// **'Hala'**
  String get hala;

  /// No description provided for @logintotrendycheftoviewandmanageyouraccount.
  ///
  /// In en, this message translates to:
  /// **'Log in to Trendy Chef to view and manage your account'**
  String get logintotrendycheftoviewandmanageyouraccount;

  /// No description provided for @follownewtrendswithus.
  ///
  /// In en, this message translates to:
  /// **'Follow New Trends With Us'**
  String get follownewtrendswithus;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cartisempty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cartisempty;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @ordersummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get ordersummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping Fee'**
  String get shipping;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @signintocontinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue\nshopping your favorites!'**
  String get signintocontinue;

  /// No description provided for @bycontinuingyouagreetoour.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our'**
  String get bycontinuingyouagreetoour;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @continuewithgoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue With Google'**
  String get continuewithgoogle;

  /// No description provided for @deliverywithin.
  ///
  /// In en, this message translates to:
  /// **'Delivery with in (1-5 Days)'**
  String get deliverywithin;

  /// No description provided for @paymentsummary.
  ///
  /// In en, this message translates to:
  /// **'Payment Summary'**
  String get paymentsummary;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @inclvat.
  ///
  /// In en, this message translates to:
  /// **'Incl. VAT'**
  String get inclvat;

  /// No description provided for @paynow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get paynow;

  /// No description provided for @recentorder.
  ///
  /// In en, this message translates to:
  /// **'Recent Order'**
  String get recentorder;

  /// No description provided for @updateyourdeliveryaddress.
  ///
  /// In en, this message translates to:
  /// **'Update Your Delivery Address'**
  String get updateyourdeliveryaddress;

  /// No description provided for @yourdetailshelpusdeliveryourordersmoothlyandontime.
  ///
  /// In en, this message translates to:
  /// **'Your details help us deliver your order smoothly and on time.'**
  String get yourdetailshelpusdeliveryourordersmoothlyandontime;

  /// No description provided for @phonenumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phonenumber;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @postalcode.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postalcode;

  /// No description provided for @streetaddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetaddress;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @noorderfound.
  ///
  /// In en, this message translates to:
  /// **'No Order found'**
  String get noorderfound;

  /// No description provided for @placeanordertoeasilymanageyourpurchases.
  ///
  /// In en, this message translates to:
  /// **'Place an order to easily\nmanage your purchases'**
  String get placeanordertoeasilymanageyourpurchases;

  /// No description provided for @vieworder.
  ///
  /// In en, this message translates to:
  /// **'View Order'**
  String get vieworder;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @statusReadyToShip.
  ///
  /// In en, this message translates to:
  /// **'Ready to ship'**
  String get statusReadyToShip;

  /// No description provided for @statusShipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get statusShipped;

  /// No description provided for @statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get statusDelivered;

  /// No description provided for @statusReturned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get statusReturned;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @paymentcancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment Cancelled'**
  String get paymentcancelled;

  /// No description provided for @yourpaymentwascancelled.
  ///
  /// In en, this message translates to:
  /// **'Your payment was cancelled'**
  String get yourpaymentwascancelled;

  /// No description provided for @backtohome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backtohome;

  /// No description provided for @tryagain.
  ///
  /// In en, this message translates to:
  /// **'Try agian'**
  String get tryagain;

  /// No description provided for @recommendedproducts.
  ///
  /// In en, this message translates to:
  /// **'Recommended Products'**
  String get recommendedproducts;

  /// No description provided for @paymenhistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymenhistory;

  /// No description provided for @dateoforder.
  ///
  /// In en, this message translates to:
  /// **'Date of Order'**
  String get dateoforder;

  /// No description provided for @paymentstatus.
  ///
  /// In en, this message translates to:
  /// **'Payment status'**
  String get paymentstatus;

  /// No description provided for @orderstatus.
  ///
  /// In en, this message translates to:
  /// **'Order status'**
  String get orderstatus;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qty;

  /// No description provided for @outofstock.
  ///
  /// In en, this message translates to:
  /// **'Out Of Stock'**
  String get outofstock;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
