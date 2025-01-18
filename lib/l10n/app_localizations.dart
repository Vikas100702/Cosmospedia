import 'package:flutter/material.dart';

class AppLocalizations{
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Add a static getter that returns a default localization
  static AppLocalizations get current {
    return AppLocalizations(const Locale('en'));
  }


  static const _localizedValues = {
    'en' : {
      // App
      'appName' : 'CosmosPedia',
      'appVersion' : '1.0.0',

      // Navigation Drawer
      'drawerHome' : 'Home',
      'drawerMissions' : 'Missions',
      'drawerApod' : 'APOD Gallery',
      'drawerRovers' : 'Mars Rovers',
      'drawerNeos' : 'Near-Earth Objects',
      'drawerEvents' : 'Astronomical Events',

      // Home Screen
      'homeLatestNews' : 'Latest Space News',
      'homeFeaturedImages' : 'Featured Images',
      'homeViewAll' : 'View All',
      'homeLoadingError' : 'Error loading data',
      'homeRetry' : 'Retry',
      'homeRefresh' : 'Refresh',

      // APOD
      'apodTitle' : 'Astronomy Picture of the Day',
      'apodLoadingError' : 'Error loading APOD',
      'apodViewFull' : 'View Full Image',
      'apodShare' : 'Share',
      'apodSave' : 'Save',

      // Common
      'loading' : 'Loading...',
      'error' : 'Error',
      'retry' : 'Retry',
      'cancel' : 'Cancel',
      'ok' : 'OK',
      'done' : 'Done',
      'save' : 'Save',
      'delete' : 'Delete',
      'edit' : 'Edit',
      'share' : 'Share',

      // Error Messages
      'errorNoInternet' : 'No internet connection',
      'errorTimeout' : 'Request timeout',
      'errorGeneric' : 'Something went wrong',
      'errorInvalidResponse' : 'Invalid response from server',
    }
  };

  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get appVersion => _localizedValues[locale.languageCode]!['appVersion']!;

// Navigation Drawer
  String get drawerHome => _localizedValues[locale.languageCode]!['drawerHome']!;
  String get drawerMissions => _localizedValues[locale.languageCode]!['drawerMissions']!;
  String get drawerApod => _localizedValues[locale.languageCode]!['drawerApod']!;
  String get drawerRovers => _localizedValues[locale.languageCode]!['drawerRovers']!;
  String get drawerNeos => _localizedValues[locale.languageCode]!['drawerNeos']!;
  String get drawerEvents => _localizedValues[locale.languageCode]!['drawerEvents']!;

// Home Screen
  String get homeLatestNews => _localizedValues[locale.languageCode]!['homeLatestNews']!;
  String get homeFeaturedImages => _localizedValues[locale.languageCode]!['homeFeaturedImages']!;
  String get homeViewAll => _localizedValues[locale.languageCode]!['homeViewAll']!;
  String get homeLoadingError => _localizedValues[locale.languageCode]!['homeLoadingError']!;
  String get homeRetry => _localizedValues[locale.languageCode]!['homeRetry']!;
  String get homeRefresh => _localizedValues[locale.languageCode]!['homeRefresh']!;

// APOD
  String get apodTitle => _localizedValues[locale.languageCode]!['apodTitle']!;
  String get apodLoadingError => _localizedValues[locale.languageCode]!['apodLoadingError']!;
  String get apodViewFull => _localizedValues[locale.languageCode]!['apodViewFull']!;
  String get apodShare => _localizedValues[locale.languageCode]!['apodShare']!;
  String get apodSave => _localizedValues[locale.languageCode]!['apodSave']!;

// Common
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get done => _localizedValues[locale.languageCode]!['done']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get share => _localizedValues[locale.languageCode]!['share']!;

// Error Messages
  String get errorNoInternet => _localizedValues[locale.languageCode]!['errorNoInternet']!;
  String get errorTimeout => _localizedValues[locale.languageCode]!['errorTimeout']!;
  String get errorGeneric => _localizedValues[locale.languageCode]!['errorGeneric']!;
  String get errorInvalidResponse => _localizedValues[locale.languageCode]!['errorInvalidResponse']!;

  String get loadingError => _localizedValues[locale.languageCode]!['loadingError']!;
}