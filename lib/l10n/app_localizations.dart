import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

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
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @your_location.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get your_location;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @explore_the_popular_category.
  ///
  /// In en, this message translates to:
  /// **'Explore The Popular Categories'**
  String get explore_the_popular_category;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @select_your_delivery_location.
  ///
  /// In en, this message translates to:
  /// **'Select Your Delivery Location'**
  String get select_your_delivery_location;

  /// No description provided for @add_new_address.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get add_new_address;

  /// No description provided for @saved_address.
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get saved_address;

  /// No description provided for @no_service_message.
  ///
  /// In en, this message translates to:
  /// **'Currently we are not serviceable in your location.\nWe are on a process of increasing our service area.'**
  String get no_service_message;

  /// No description provided for @notify_service.
  ///
  /// In en, this message translates to:
  /// **'We will notify you once we start our service in your area'**
  String get notify_service;

  /// No description provided for @search_in.
  ///
  /// In en, this message translates to:
  /// **'Search in'**
  String get search_in;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @dishes.
  ///
  /// In en, this message translates to:
  /// **'Dishes'**
  String get dishes;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get read_more;

  /// No description provided for @read_less.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get read_less;

  /// No description provided for @total_balance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get total_balance;

  /// No description provided for @add_credit_card.
  ///
  /// In en, this message translates to:
  /// **'Add Credit Card/ Debit Card'**
  String get add_credit_card;

  /// No description provided for @net_banking.
  ///
  /// In en, this message translates to:
  /// **'Net Banking'**
  String get net_banking;

  /// No description provided for @add_later.
  ///
  /// In en, this message translates to:
  /// **'Add Later'**
  String get add_later;

  /// No description provided for @add_cash_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Add Cash to Wallet'**
  String get add_cash_to_wallet;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @where_are_you_going_today.
  ///
  /// In en, this message translates to:
  /// **'Where are you going'**
  String get where_are_you_going_today;

  /// No description provided for @pick_up.
  ///
  /// In en, this message translates to:
  /// **'Pick-up'**
  String get pick_up;

  /// No description provided for @my_current_location.
  ///
  /// In en, this message translates to:
  /// **'My current location'**
  String get my_current_location;

  /// No description provided for @drop_off.
  ///
  /// In en, this message translates to:
  /// **'Drop off'**
  String get drop_off;

  /// No description provided for @where_to.
  ///
  /// In en, this message translates to:
  /// **'Where to?'**
  String get where_to;

  /// No description provided for @saved_places.
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get saved_places;

  /// No description provided for @choose_your_ride.
  ///
  /// In en, this message translates to:
  /// **'Choose your ride'**
  String get choose_your_ride;

  /// No description provided for @promo_code.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promo_code;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @loading_your_nearest_driver.
  ///
  /// In en, this message translates to:
  /// **'Loading Your Nearest Driver'**
  String get loading_your_nearest_driver;

  /// No description provided for @loading_driver_dialogue.
  ///
  /// In en, this message translates to:
  /// **'Hang tight! We\'re connecting you with\nthe closest available driver. This may\n take a moment.'**
  String get loading_driver_dialogue;

  /// No description provided for @no_service.
  ///
  /// In en, this message translates to:
  /// **'Hold your horses!   We\'re not quite there yet, but we\'re bringing our service to your area soon. Stay tuned!'**
  String get no_service;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
