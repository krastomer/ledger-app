// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ledger';

  @override
  String get navHome => 'Home';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navInbox => 'Inbox';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeTitle => 'Overview';

  @override
  String get hideAmounts => 'Hide amounts';

  @override
  String get showAmounts => 'Show amounts';

  @override
  String get netWorth => 'Net worth';

  @override
  String get seeAccounts => 'Accounts';

  @override
  String get assets => 'Assets';

  @override
  String get liabilities => 'Liabilities';

  @override
  String reviewBannerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items to review',
      one: '1 item to review',
    );
    return '$_temp0';
  }

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get net => 'Net';

  @override
  String get seeReports => 'Reports';

  @override
  String get topSpending => 'Top spending';

  @override
  String get recent => 'Recent';

  @override
  String get seeAll => 'See all';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get loadFailed => 'Couldn\'t load your ledger';

  @override
  String get retry => 'Try again';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get accountsTitle => 'Accounts';

  @override
  String get reportsTitle => 'Reports';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsYearFormat => 'Year format';

  @override
  String get languageThai => 'ไทย';

  @override
  String get languageEnglish => 'English';

  @override
  String yearBuddhistEra(int year) {
    return 'B.E. $year';
  }

  @override
  String yearCommonEra(int year) {
    return 'A.D. $year';
  }

  @override
  String get settingsSaveFailed => 'Couldn\'t save the setting';
}
