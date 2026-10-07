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

  @override
  String get dailySpendTitle => 'Daily spend';

  @override
  String dailySpendCalendar(String month) {
    return 'Daily spending calendar for $month';
  }

  @override
  String dailyAverage(String amount) {
    return 'avg $amount/day';
  }

  @override
  String get dailyPeak => 'peak';

  @override
  String get settingsDisplay => 'Display';

  @override
  String get settingsHideOnLaunch => 'Hide on launch';

  @override
  String get settingsHideOnLaunchHint => 'amounts on home start hidden';

  @override
  String get settingsShowZeroBalance => 'Show zero balance';

  @override
  String get settingsHiddenAccounts => 'Hidden accounts';

  @override
  String get settingsHomeCards => 'Home cards';

  @override
  String get settingsStorage => 'Storage';

  @override
  String get settingsKeepSlipImages => 'Keep slip images';

  @override
  String get settingsKeepSlipImagesHint =>
      'false = keep only the extracted data';

  @override
  String get settingsLastBackup => 'backup.last';

  @override
  String get backupNever => 'never';

  @override
  String get backUpAction => 'Back up';

  @override
  String get restoreAction => 'Restore';

  @override
  String get restoreReplacesData => 'restore replaces all data';

  @override
  String get bootHeader => 'ledger · tty0';

  @override
  String get bootOnDevice => 'on-device';

  @override
  String bootOpened(int count) {
    return 'Opened ledger: $count entries';
  }

  @override
  String bootParsed(String from, String to) {
    return 'Read $from..$to';
  }

  @override
  String get bootBalanced => 'Checked balances';

  @override
  String bootUnbalanced(int count) {
    return '$count entries don\'t balance';
  }

  @override
  String bootOcr(String engine) {
    return 'Started OCR ($engine)';
  }

  @override
  String get bootFailed => 'Couldn\'t open the ledger';

  @override
  String get nothingToReview => 'Nothing to review';

  @override
  String get continueAction => 'Continue';

  @override
  String get newSlipsTitle => 'New slips';

  @override
  String get newSlipsHint =>
      'Pick slip images from your photos. They\'re read on this phone.';

  @override
  String get pickSlipsAction => 'Pick slips';

  @override
  String get queueTitle => 'Queue';

  @override
  String openCount(int count) {
    return '$count open';
  }

  @override
  String get reviewTagPending => 'CONFIRM';

  @override
  String get reviewTagDuplicate => 'DUP?';

  @override
  String get reviewTagUncategorized => 'NO CAT';

  @override
  String get duplicateHint => 'same day and postings as another entry';

  @override
  String get confirmAction => 'Confirm';

  @override
  String get keepAction => 'Keep';

  @override
  String get dropOneAction => 'Drop one';

  @override
  String get categorizeAction => 'Categorize';

  @override
  String get categoryTitle => 'Category';

  @override
  String get accountTitle => 'Account';

  @override
  String get slipsReadOnDevice =>
      'slips are read on-device; nothing leaves this phone';

  @override
  String get changeFailed => 'Couldn\'t save the change';

  @override
  String get photosFailed => 'Couldn\'t open your photos';

  @override
  String get transactionTitle => 'Transaction';

  @override
  String get statusCleared => 'cleared';

  @override
  String get kindExpense => 'expense';

  @override
  String get kindIncome => 'income';

  @override
  String get kindTransfer => 'transfer';

  @override
  String codeLabel(String code) {
    return 'code $code';
  }

  @override
  String get postingsTitle => 'Postings';

  @override
  String get balanced => 'balanced';

  @override
  String get notBalanced => 'not balanced';

  @override
  String get slipTitle => 'Slip';

  @override
  String get refLabel => 'ref';

  @override
  String get journalEntryTitle => 'Journal';

  @override
  String get copyAction => 'Copy';

  @override
  String get deleteAction => 'Delete';

  @override
  String get deleteTransaction => 'Delete transaction';

  @override
  String get copied => 'Copied';

  @override
  String get deleteConfirm => 'Delete this entry?';

  @override
  String get transactionNotFound => 'This entry no longer exists';

  @override
  String get closeAction => 'Close';

  @override
  String slipProgress(int index, int count) {
    return 'Slip $index of $count';
  }

  @override
  String get slipKindTransfer => 'transfer';

  @override
  String get slipKindPayment => 'payment';

  @override
  String get slipKindBuy => 'buy';

  @override
  String get slipKindSell => 'sell';

  @override
  String get amountLabel => 'amount';

  @override
  String get dateLabel => 'date';

  @override
  String get engineLabel => 'engine';

  @override
  String get dupLabel => 'dup';

  @override
  String get dupNone => 'none';

  @override
  String dupFound(String date) {
    return 'saved $date';
  }

  @override
  String get fieldsTitle => 'Fields';

  @override
  String get fromLabel => 'from';

  @override
  String get toLabel => 'to';

  @override
  String get feeLabel => 'fee';

  @override
  String get notOnSlip => 'not on slip';

  @override
  String get unclearCheck => 'unclear, please check';

  @override
  String get willWriteTitle => 'Will write';

  @override
  String get hintFromHistory => 'used before for this payee';

  @override
  String get hintPickCategory => 'pick a category';

  @override
  String hintFromSlip(String source) {
    return 'from $source';
  }

  @override
  String get skipAction => 'Skip';

  @override
  String get saveNextAction => 'Save & next';

  @override
  String get slipUnreadable => 'Couldn\'t read this slip';

  @override
  String get slipNoAmount => 'No amount on this slip';

  @override
  String get readingSlip => 'reading slip';

  @override
  String slipsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count slips saved',
      one: '1 slip saved',
    );
    return '$_temp0';
  }

  @override
  String get descriptionTitle => 'Description';

  @override
  String get viewSlipImage => 'View slip image';

  @override
  String get bootOpening => 'Opening ledger';
}
