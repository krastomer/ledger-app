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
  String get filterHint => 'filter';

  @override
  String get noMatches => 'no match';

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
  String get settingsShowJournal => 'Show journal';

  @override
  String get settingsShowJournalHint => 'hledger text on each entry';

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
  String get viewImageAction => 'View image';

  @override
  String get slipImageMissing => 'This slip image is no longer on the device';

  @override
  String get bootOpening => 'Opening ledger';

  @override
  String get setupHeader => 'ledger · setup';

  @override
  String get setupTitle => 'Setup';

  @override
  String get setupStartNew => 'Start new ledger';

  @override
  String get setupStartNewHint => 'Empty books, filled from your slips';

  @override
  String get setupImport => 'Import hledger';

  @override
  String get setupImportHint => 'A file from hledger print -O json';

  @override
  String get setupNewTitle => 'New ledger';

  @override
  String get setupCurrency => 'Currency';

  @override
  String get setupAccountsHint => 'Sub-accounts appear as you record entries';

  @override
  String get setupCreate => 'Create ledger';

  @override
  String get setupSourceTitle => 'Source';

  @override
  String get setupChooseFile => 'Choose file';

  @override
  String get setupChooseAnother => 'Choose another file';

  @override
  String get setupPickHint => 'Pick the file made by hledger print -O json';

  @override
  String get setupFile => 'File';

  @override
  String get setupSize => 'Size';

  @override
  String get setupFoundTitle => 'Found';

  @override
  String get setupTransactions => 'Transactions';

  @override
  String get setupRange => 'Range';

  @override
  String get setupAllBalanced => 'All balanced';

  @override
  String setupUnbalanced(int count) {
    return '$count don\'t balance';
  }

  @override
  String setupImportAction(int count) {
    return 'Import $count';
  }

  @override
  String setupUnreadable(int count) {
    return 'Can\'t read $count entries in this file';
  }

  @override
  String get setupFileFailed => 'Couldn\'t open the file';

  @override
  String setupStep(int step, int total) {
    return 'step $step/$total';
  }

  @override
  String get setupSettingsTitle => 'Settings';

  @override
  String get setupPrivacy => 'Privacy';

  @override
  String get setupChangeLater => 'All of these can be changed later in config.';

  @override
  String get setupPhotosTitle => 'Slip photos';

  @override
  String get setupSyncGallery => 'Sync gallery';

  @override
  String get setupSyncGalleryHint => 'find new slips in your photo library';

  @override
  String get setupScopeScreenshots => 'Screenshots album';

  @override
  String get setupScopeScreenshotsHint => 'where bank apps save slips';

  @override
  String get setupScopeAll => 'All photos';

  @override
  String get setupScopeAllHint => 'scans everything, slower';

  @override
  String get setupPhotosHint =>
      'Photos never leave the device. You can turn this on or off later in config.';

  @override
  String get setupFinish => 'Finish';

  @override
  String get setupHowTitle => 'How it works';

  @override
  String get setupHowSteps =>
      '1. ledger asks for photo access\n2. new images are read by on-device ocr\n3. it counts the slips it finds\n4. you pick which ones to import\n5. other photos are ignored';

  @override
  String get setupPhotosScan => 'Scan photos';

  @override
  String get setupScanTitle => 'Scanning photo library';

  @override
  String get setupScanCancel => 'Cancel';

  @override
  String get setupScanScanning => 'Scanning...';

  @override
  String setupScanLibrary(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString photos in library';
  }

  @override
  String setupScanToCheckScreenshots(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString screenshots to check';
  }

  @override
  String setupScanToCheckAll(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString photos to check';
  }

  @override
  String setupScanRead(int done, int total) {
    final intl.NumberFormat doneNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String doneString = doneNumberFormat.format(done);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return 'read text from $doneString of $totalString';
  }

  @override
  String setupScanFound(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString slips found';
  }

  @override
  String get setupScanHint =>
      'reading text on this device. nothing is uploaded.';

  @override
  String setupScanReview(int count) {
    return 'Review $count found';
  }

  @override
  String get setupScanNoAccess => 'No access to your photos';

  @override
  String get setupScanNoAccessHint =>
      'Allow photo access in the system settings, then scan again from config.';

  @override
  String get setupScanFailed => 'Couldn\'t read the photo library';

  @override
  String setupFoundSelected(int selected, int total) {
    return '$selected of $total selected';
  }

  @override
  String get setupSelectAll => 'Select all';

  @override
  String get setupSelectNone => 'Select none';

  @override
  String get setupFoundTransfers => 'Transfers';

  @override
  String get setupFoundPayments => 'Payments';

  @override
  String get setupFoundOrders => 'Orders';

  @override
  String get setupFoundUnsure => 'Not sure';

  @override
  String get setupFoundNoAmount => 'looks like a slip, no amount';

  @override
  String get setupFoundInboxHint => 'goes to inbox for review';

  @override
  String setupFoundImport(int count) {
    return 'Import $count';
  }

  @override
  String get setupFoundSkip => 'Skip';

  @override
  String get setupSaveFailed => 'Couldn\'t set up the ledger';

  @override
  String get settingsRules => 'Rules';

  @override
  String get rulesTitle => 'Rules';

  @override
  String get rulesSourceTitle => 'Source';

  @override
  String get rulesFile => 'File';

  @override
  String get rulesLoaded => 'Loaded';

  @override
  String get rulesSkipped => 'Skipped';

  @override
  String get rulesNone => '(none)';

  @override
  String get rulesNoFile => 'no rules file yet';

  @override
  String rulesLoadedCount(int count) {
    return '$count loaded · view or replace';
  }

  @override
  String rulesCount(int count) {
    return '$count loaded';
  }

  @override
  String get rulesViewOnly => 'view-only · edit the file, then replace it';

  @override
  String get rulesReplaceNote => 'a new file replaces every rule above';

  @override
  String get rulesFirstMatch => 'first match wins, top to bottom';

  @override
  String get rulesReplaceAction => 'Replace file';

  @override
  String get rulesChooseAction => 'Choose file';

  @override
  String get rulesLoadFailed => 'Couldn\'t read the saved rules';

  @override
  String get rulesFileFailed => 'Couldn\'t open the file';

  @override
  String get rulesNoneFound => 'No rules found in this file';

  @override
  String get rulesSaveFailed => 'Couldn\'t save the rules';

  @override
  String rulesSkippedLine(int line) {
    return 'line $line skipped';
  }

  @override
  String get rulesReasonBadRegex => 'bad regex';

  @override
  String get rulesReasonMissingAccount => 'no account2 line';

  @override
  String get rulesReasonUnknownField => 'unknown field';

  @override
  String get rulesReasonUnknownDirective => 'unknown directive';

  @override
  String get setupRulesFileTitle => 'Rules file';

  @override
  String get setupRulesOptional => 'optional';

  @override
  String get setupRulesFoundTitle => 'Rules found';

  @override
  String get setupRulesFormatTitle => 'File format · hledger style';

  @override
  String get setupRulesHintViewOnly => 'rules are view-only in the app';

  @override
  String get setupRulesHintEdit =>
      'to change them, edit the file and replace it';

  @override
  String get setupRulesHintOrder =>
      'first match wins · hand-set categories are kept';

  @override
  String get setupRulesSkip => 'Skip';

  @override
  String setupRulesImport(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Import $count rules',
      one: 'Import 1 rule',
    );
    return '$_temp0';
  }
}
