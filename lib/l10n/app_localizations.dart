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
      'settings' : 'Settings',
      'language' : 'Language',
      't&c' : 'Terms and Conditions',
      'privacyPolicy' : 'Privacy Policies',
      'helpSupport' : 'Help and Support',
      'logout' : 'Logout',

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

      //News Screen
      'noNewsAvailable': 'No cosmic news available right now 🌌',
      'imagePreview' : 'Preview Image',

      //ImagePreviewDownload
      'downloadImage' : 'Download Image',
      'imageDownloadSuccess' : 'Image downloaded successfully',
      'imageDownloadError' : 'Error downloading image',
      'storagePermissionDenied' : 'Storage permission is required to download images',

      //Mars Rover Explorer
      'marsRoverExplorer' : 'Mars Rover Explorer',

      //Browse by Rover
      'browseByRover' : 'Browse By Rover',
      'curiosity' : 'Curiosity',
      'opportunity' : 'Opportunity',
      'spirit' : 'Spirit',

      //Asteroids
      'asteroidsTitle' : 'Asteroids Near Earth',

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
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get termConditions => _localizedValues[locale.languageCode]!['t&c']!;
  String get privacyPolicy => _localizedValues[locale.languageCode]!['privacyPolicy']!;
  String get helpSupport => _localizedValues[locale.languageCode]!['helpSupport']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;

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

  //News Screen
  String get noNewsAvailable => _localizedValues[locale.languageCode]!['noNewsAvailable']!;
  String get imagePreview => _localizedValues[locale.languageCode]!['imagePreview']!;

  //ImagePreviewDownload
  String get downloadImage => _localizedValues[locale.languageCode]!['downloadImage']!;
  String get imageDownloadSuccess => _localizedValues[locale.languageCode]!['imageDownloadSuccess']!;
  String get imageDownloadError => _localizedValues[locale.languageCode]!['imageDownloadError']!;
  String get storagePermissionDenied => _localizedValues[locale.languageCode]!['storagePermissionDenied']!;

  //Mars Rover Explorer
  String get marsRoverExplorer => _localizedValues[locale.languageCode]!['marsRoverExplorer']!;

  //browse by Rover
  String get browseByRover => _localizedValues[locale.languageCode]!['browseByRover']!;
  String get curiosity => _localizedValues[locale.languageCode]!['curiosity']!;
  String get opportunity => _localizedValues[locale.languageCode]!['opportunity']!;
  String get spirit => _localizedValues[locale.languageCode]!['spirit']!;

  //Asteroids
  String get asteroidsTitle => _localizedValues[locale.languageCode]!['asteroidsNearEarth']!;

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