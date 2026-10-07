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
  String get navTransactions => 'Journal';

  @override
  String get navInbox => 'Inbox';

  @override
  String get navSettings => 'Config';

  @override
  String get hideAmounts => 'Hide amounts';

  @override
  String get showAmounts => 'Show amounts';

  @override
  String get netWorth => 'Net worth';

  @override
  String get assets => 'Assets';

  @override
  String get liabilities => 'Liabilities';

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

  @override
  String get netIncome => 'Net income';

  @override
  String get previousMonth => 'Previous month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get noTransactionsThisMonth => 'No transactions this month';

  @override
  String get searchTransactions => 'Search transactions';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get filterPending => 'To review';

  @override
  String get today => 'Today';

  @override
  String get slipAttached => 'Slip attached';

  @override
  String get noMatchingTransactions => 'No matching transactions';

  @override
  String get netLabel => 'Net';

  @override
  String get generalCategory => 'General';

  @override
  String get leftOver => 'Left over';

  @override
  String subcategoriesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count subcategories',
      one: '1 subcategory',
    );
    return '$_temp0';
  }

  @override
  String entriesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String get allocationItem => 'Item';

  @override
  String get allocationShare => 'Share';

  @override
  String get allocationAmount => 'Amount';

  @override
  String shareOfParent(String percent, String parent) {
    return '$percent of $parent';
  }

  @override
  String accountsAsOf(String date) {
    return 'As of $date';
  }

  @override
  String get balanceView => 'Balance';

  @override
  String get monthChangeView => 'This month\'s change';

  @override
  String expandAccount(String name) {
    return 'Expand $name';
  }

  @override
  String collapseAccount(String name) {
    return 'Collapse $name';
  }

  @override
  String get noAccounts => 'No accounts yet';

  @override
  String itemsNeedReview(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'items need review',
      one: 'item needs review',
    );
    return '$_temp0';
  }

  @override
  String get openAction => 'Open';

  @override
  String get hideAction => 'Hide';

  @override
  String get showAction => 'Show';

  @override
  String get back => 'Back';

  @override
  String get filterPendingFlag => '--pending';

  @override
  String get filterSlipFlag => '--slip';

  @override
  String get registerTitle => 'Register';

  @override
  String shownCount(int count) {
    return '$count shown';
  }

  @override
  String get balanceSheetTitle => 'Balance sheet';

  @override
  String get incomeStatementTitle => 'Income statement';

  @override
  String savedPercent(String percent) {
    return '$percent saved';
  }

  @override
  String get configFileTitle => '~/.ledgerrc';

  @override
  String get dataStaysOnDevice => 'All data stays on this device';
}
