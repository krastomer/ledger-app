import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ledger'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTransactions.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navTransactions;

  /// No description provided for @navInbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get navInbox;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Config'**
  String get navSettings;

  /// No description provided for @hideAmounts.
  ///
  /// In en, this message translates to:
  /// **'Hide amounts'**
  String get hideAmounts;

  /// No description provided for @showAmounts.
  ///
  /// In en, this message translates to:
  /// **'Show amounts'**
  String get showAmounts;

  /// No description provided for @netWorth.
  ///
  /// In en, this message translates to:
  /// **'Net worth'**
  String get netWorth;

  /// No description provided for @assets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assets;

  /// No description provided for @liabilities.
  ///
  /// In en, this message translates to:
  /// **'Liabilities'**
  String get liabilities;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get net;

  /// No description provided for @seeReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get seeReports;

  /// No description provided for @topSpending.
  ///
  /// In en, this message translates to:
  /// **'Top spending'**
  String get topSpending;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your ledger'**
  String get loadFailed;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @accountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accountsTitle;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsYearFormat.
  ///
  /// In en, this message translates to:
  /// **'Year format'**
  String get settingsYearFormat;

  /// No description provided for @languageThai.
  ///
  /// In en, this message translates to:
  /// **'ไทย'**
  String get languageThai;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @yearBuddhistEra.
  ///
  /// In en, this message translates to:
  /// **'B.E. {year}'**
  String yearBuddhistEra(int year);

  /// No description provided for @yearCommonEra.
  ///
  /// In en, this message translates to:
  /// **'A.D. {year}'**
  String yearCommonEra(int year);

  /// No description provided for @settingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the setting'**
  String get settingsSaveFailed;

  /// No description provided for @netIncome.
  ///
  /// In en, this message translates to:
  /// **'Net income'**
  String get netIncome;

  /// No description provided for @previousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get previousMonth;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// No description provided for @noTransactionsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'No transactions this month'**
  String get noTransactionsThisMonth;

  /// No description provided for @searchTransactions.
  ///
  /// In en, this message translates to:
  /// **'Search transactions'**
  String get searchTransactions;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'To review'**
  String get filterPending;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @slipAttached.
  ///
  /// In en, this message translates to:
  /// **'Slip attached'**
  String get slipAttached;

  /// No description provided for @filterHint.
  ///
  /// In en, this message translates to:
  /// **'filter'**
  String get filterHint;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'no match'**
  String get noMatches;

  /// No description provided for @noMatchingTransactions.
  ///
  /// In en, this message translates to:
  /// **'No matching transactions'**
  String get noMatchingTransactions;

  /// No description provided for @netLabel.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get netLabel;

  /// No description provided for @generalCategory.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalCategory;

  /// No description provided for @leftOver.
  ///
  /// In en, this message translates to:
  /// **'Left over'**
  String get leftOver;

  /// No description provided for @subcategoriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 subcategory} other{{count} subcategories}}'**
  String subcategoriesCount(num count);

  /// No description provided for @entriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 entry} other{{count} entries}}'**
  String entriesCount(num count);

  /// No description provided for @allocationItem.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get allocationItem;

  /// No description provided for @allocationShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get allocationShare;

  /// No description provided for @allocationAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get allocationAmount;

  /// No description provided for @shareOfParent.
  ///
  /// In en, this message translates to:
  /// **'{percent} of {parent}'**
  String shareOfParent(String percent, String parent);

  /// No description provided for @accountsAsOf.
  ///
  /// In en, this message translates to:
  /// **'As of {date}'**
  String accountsAsOf(String date);

  /// No description provided for @balanceView.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceView;

  /// No description provided for @monthChangeView.
  ///
  /// In en, this message translates to:
  /// **'This month\'s change'**
  String get monthChangeView;

  /// No description provided for @expandAccount.
  ///
  /// In en, this message translates to:
  /// **'Expand {name}'**
  String expandAccount(String name);

  /// No description provided for @collapseAccount.
  ///
  /// In en, this message translates to:
  /// **'Collapse {name}'**
  String collapseAccount(String name);

  /// No description provided for @noAccounts.
  ///
  /// In en, this message translates to:
  /// **'No accounts yet'**
  String get noAccounts;

  /// No description provided for @itemsNeedReview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{item needs review} other{items need review}}'**
  String itemsNeedReview(int count);

  /// No description provided for @openAction.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openAction;

  /// No description provided for @hideAction.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hideAction;

  /// No description provided for @showAction.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get showAction;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @filterPendingFlag.
  ///
  /// In en, this message translates to:
  /// **'--pending'**
  String get filterPendingFlag;

  /// No description provided for @filterSlipFlag.
  ///
  /// In en, this message translates to:
  /// **'--slip'**
  String get filterSlipFlag;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerTitle;

  /// No description provided for @shownCount.
  ///
  /// In en, this message translates to:
  /// **'{count} shown'**
  String shownCount(int count);

  /// No description provided for @balanceSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Balance sheet'**
  String get balanceSheetTitle;

  /// No description provided for @incomeStatementTitle.
  ///
  /// In en, this message translates to:
  /// **'Income statement'**
  String get incomeStatementTitle;

  /// No description provided for @savedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent} saved'**
  String savedPercent(String percent);

  /// No description provided for @configFileTitle.
  ///
  /// In en, this message translates to:
  /// **'~/.ledgerrc'**
  String get configFileTitle;

  /// No description provided for @dataStaysOnDevice.
  ///
  /// In en, this message translates to:
  /// **'All data stays on this device'**
  String get dataStaysOnDevice;

  /// No description provided for @dailySpendTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily spend'**
  String get dailySpendTitle;

  /// No description provided for @dailySpendCalendar.
  ///
  /// In en, this message translates to:
  /// **'Daily spending calendar for {month}'**
  String dailySpendCalendar(String month);

  /// No description provided for @dailyAverage.
  ///
  /// In en, this message translates to:
  /// **'avg {amount}/day'**
  String dailyAverage(String amount);

  /// No description provided for @dailyPeak.
  ///
  /// In en, this message translates to:
  /// **'peak'**
  String get dailyPeak;

  /// No description provided for @settingsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get settingsDisplay;

  /// No description provided for @settingsHideOnLaunch.
  ///
  /// In en, this message translates to:
  /// **'Hide on launch'**
  String get settingsHideOnLaunch;

  /// No description provided for @settingsHideOnLaunchHint.
  ///
  /// In en, this message translates to:
  /// **'amounts on home start hidden'**
  String get settingsHideOnLaunchHint;

  /// No description provided for @settingsShowJournal.
  ///
  /// In en, this message translates to:
  /// **'Show journal'**
  String get settingsShowJournal;

  /// No description provided for @settingsShowJournalHint.
  ///
  /// In en, this message translates to:
  /// **'hledger text on each entry'**
  String get settingsShowJournalHint;

  /// No description provided for @settingsHiddenAccounts.
  ///
  /// In en, this message translates to:
  /// **'Hidden accounts'**
  String get settingsHiddenAccounts;

  /// No description provided for @settingsHomeCards.
  ///
  /// In en, this message translates to:
  /// **'Home cards'**
  String get settingsHomeCards;

  /// No description provided for @settingsStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get settingsStorage;

  /// No description provided for @settingsKeepSlipImages.
  ///
  /// In en, this message translates to:
  /// **'Keep slip images'**
  String get settingsKeepSlipImages;

  /// No description provided for @settingsKeepSlipImagesHint.
  ///
  /// In en, this message translates to:
  /// **'false = keep only the extracted data'**
  String get settingsKeepSlipImagesHint;

  /// No description provided for @settingsLastBackup.
  ///
  /// In en, this message translates to:
  /// **'backup.last'**
  String get settingsLastBackup;

  /// No description provided for @backupNever.
  ///
  /// In en, this message translates to:
  /// **'never'**
  String get backupNever;

  /// No description provided for @backUpAction.
  ///
  /// In en, this message translates to:
  /// **'Back up'**
  String get backUpAction;

  /// No description provided for @restoreAction.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreAction;

  /// No description provided for @restoreReplacesData.
  ///
  /// In en, this message translates to:
  /// **'restore replaces all data'**
  String get restoreReplacesData;

  /// No description provided for @bootHeader.
  ///
  /// In en, this message translates to:
  /// **'ledger · tty0'**
  String get bootHeader;

  /// No description provided for @bootOnDevice.
  ///
  /// In en, this message translates to:
  /// **'on-device'**
  String get bootOnDevice;

  /// No description provided for @bootOpened.
  ///
  /// In en, this message translates to:
  /// **'Opened ledger: {count} entries'**
  String bootOpened(int count);

  /// No description provided for @bootParsed.
  ///
  /// In en, this message translates to:
  /// **'Read {from}..{to}'**
  String bootParsed(String from, String to);

  /// No description provided for @bootBalanced.
  ///
  /// In en, this message translates to:
  /// **'Checked balances'**
  String get bootBalanced;

  /// No description provided for @bootUnbalanced.
  ///
  /// In en, this message translates to:
  /// **'{count} entries don\'t balance'**
  String bootUnbalanced(int count);

  /// No description provided for @bootOcr.
  ///
  /// In en, this message translates to:
  /// **'Started OCR ({engine})'**
  String bootOcr(String engine);

  /// No description provided for @bootFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the ledger'**
  String get bootFailed;

  /// No description provided for @nothingToReview.
  ///
  /// In en, this message translates to:
  /// **'Nothing to review'**
  String get nothingToReview;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @newSlipsTitle.
  ///
  /// In en, this message translates to:
  /// **'New slips'**
  String get newSlipsTitle;

  /// No description provided for @newSlipsHint.
  ///
  /// In en, this message translates to:
  /// **'Pick slip images from your photos. They\'re read on this phone.'**
  String get newSlipsHint;

  /// No description provided for @pickSlipsAction.
  ///
  /// In en, this message translates to:
  /// **'Pick slips'**
  String get pickSlipsAction;

  /// No description provided for @queueTitle.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get queueTitle;

  /// No description provided for @openCount.
  ///
  /// In en, this message translates to:
  /// **'{count} open'**
  String openCount(int count);

  /// No description provided for @reviewTagPending.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM'**
  String get reviewTagPending;

  /// No description provided for @reviewTagDuplicate.
  ///
  /// In en, this message translates to:
  /// **'DUP?'**
  String get reviewTagDuplicate;

  /// No description provided for @reviewTagUncategorized.
  ///
  /// In en, this message translates to:
  /// **'NO CAT'**
  String get reviewTagUncategorized;

  /// No description provided for @duplicateHint.
  ///
  /// In en, this message translates to:
  /// **'same day and postings as another entry'**
  String get duplicateHint;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmAction;

  /// No description provided for @keepAction.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keepAction;

  /// No description provided for @dropOneAction.
  ///
  /// In en, this message translates to:
  /// **'Drop one'**
  String get dropOneAction;

  /// No description provided for @categorizeAction.
  ///
  /// In en, this message translates to:
  /// **'Categorize'**
  String get categorizeAction;

  /// No description provided for @categoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryTitle;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @slipsReadOnDevice.
  ///
  /// In en, this message translates to:
  /// **'slips are read on-device; nothing leaves this phone'**
  String get slipsReadOnDevice;

  /// No description provided for @changeFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the change'**
  String get changeFailed;

  /// No description provided for @photosFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open your photos'**
  String get photosFailed;

  /// No description provided for @transactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionTitle;

  /// No description provided for @statusCleared.
  ///
  /// In en, this message translates to:
  /// **'cleared'**
  String get statusCleared;

  /// No description provided for @kindExpense.
  ///
  /// In en, this message translates to:
  /// **'expense'**
  String get kindExpense;

  /// No description provided for @kindIncome.
  ///
  /// In en, this message translates to:
  /// **'income'**
  String get kindIncome;

  /// No description provided for @kindTransfer.
  ///
  /// In en, this message translates to:
  /// **'transfer'**
  String get kindTransfer;

  /// No description provided for @codeLabel.
  ///
  /// In en, this message translates to:
  /// **'code {code}'**
  String codeLabel(String code);

  /// No description provided for @postingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Postings'**
  String get postingsTitle;

  /// No description provided for @balanced.
  ///
  /// In en, this message translates to:
  /// **'balanced'**
  String get balanced;

  /// No description provided for @notBalanced.
  ///
  /// In en, this message translates to:
  /// **'not balanced'**
  String get notBalanced;

  /// No description provided for @slipTitle.
  ///
  /// In en, this message translates to:
  /// **'Slip'**
  String get slipTitle;

  /// No description provided for @refLabel.
  ///
  /// In en, this message translates to:
  /// **'ref'**
  String get refLabel;

  /// No description provided for @journalEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journalEntryTitle;

  /// No description provided for @copyAction.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @deleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'Delete transaction'**
  String get deleteTransaction;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get deleteConfirm;

  /// No description provided for @transactionNotFound.
  ///
  /// In en, this message translates to:
  /// **'This entry no longer exists'**
  String get transactionNotFound;

  /// No description provided for @closeAction.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeAction;

  /// No description provided for @slipProgress.
  ///
  /// In en, this message translates to:
  /// **'Slip {index} of {count}'**
  String slipProgress(int index, int count);

  /// No description provided for @slipKindTransfer.
  ///
  /// In en, this message translates to:
  /// **'transfer'**
  String get slipKindTransfer;

  /// No description provided for @slipKindPayment.
  ///
  /// In en, this message translates to:
  /// **'payment'**
  String get slipKindPayment;

  /// No description provided for @slipKindBuy.
  ///
  /// In en, this message translates to:
  /// **'buy'**
  String get slipKindBuy;

  /// No description provided for @slipKindSell.
  ///
  /// In en, this message translates to:
  /// **'sell'**
  String get slipKindSell;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'amount'**
  String get amountLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'date'**
  String get dateLabel;

  /// No description provided for @engineLabel.
  ///
  /// In en, this message translates to:
  /// **'engine'**
  String get engineLabel;

  /// No description provided for @dupLabel.
  ///
  /// In en, this message translates to:
  /// **'dup'**
  String get dupLabel;

  /// No description provided for @dupNone.
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get dupNone;

  /// No description provided for @dupFound.
  ///
  /// In en, this message translates to:
  /// **'saved {date}'**
  String dupFound(String date);

  /// No description provided for @fieldsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fields'**
  String get fieldsTitle;

  /// No description provided for @fromLabel.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get fromLabel;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get toLabel;

  /// No description provided for @feeLabel.
  ///
  /// In en, this message translates to:
  /// **'fee'**
  String get feeLabel;

  /// No description provided for @notOnSlip.
  ///
  /// In en, this message translates to:
  /// **'not on slip'**
  String get notOnSlip;

  /// No description provided for @unclearCheck.
  ///
  /// In en, this message translates to:
  /// **'unclear, please check'**
  String get unclearCheck;

  /// No description provided for @willWriteTitle.
  ///
  /// In en, this message translates to:
  /// **'Will write'**
  String get willWriteTitle;

  /// No description provided for @hintFromHistory.
  ///
  /// In en, this message translates to:
  /// **'used before for this payee'**
  String get hintFromHistory;

  /// No description provided for @hintPickCategory.
  ///
  /// In en, this message translates to:
  /// **'pick a category'**
  String get hintPickCategory;

  /// No description provided for @hintFromSlip.
  ///
  /// In en, this message translates to:
  /// **'from {source}'**
  String hintFromSlip(String source);

  /// No description provided for @skipAction.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipAction;

  /// No description provided for @saveNextAction.
  ///
  /// In en, this message translates to:
  /// **'Save & next'**
  String get saveNextAction;

  /// No description provided for @slipUnreadable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read this slip'**
  String get slipUnreadable;

  /// No description provided for @slipNoAmount.
  ///
  /// In en, this message translates to:
  /// **'No amount on this slip'**
  String get slipNoAmount;

  /// No description provided for @readingSlip.
  ///
  /// In en, this message translates to:
  /// **'reading slip'**
  String get readingSlip;

  /// No description provided for @slipsSaved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 slip saved} other{{count} slips saved}}'**
  String slipsSaved(int count);

  /// No description provided for @descriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionTitle;

  /// No description provided for @viewSlipImage.
  ///
  /// In en, this message translates to:
  /// **'View slip image'**
  String get viewSlipImage;

  /// No description provided for @viewImageAction.
  ///
  /// In en, this message translates to:
  /// **'View image'**
  String get viewImageAction;

  /// No description provided for @slipImageMissing.
  ///
  /// In en, this message translates to:
  /// **'This slip image is no longer on the device'**
  String get slipImageMissing;

  /// No description provided for @bootOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening ledger'**
  String get bootOpening;

  /// No description provided for @setupHeader.
  ///
  /// In en, this message translates to:
  /// **'ledger · setup'**
  String get setupHeader;

  /// No description provided for @setupNoLedger.
  ///
  /// In en, this message translates to:
  /// **'No ledger on this device yet.'**
  String get setupNoLedger;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get setupTitle;

  /// No description provided for @setupStartNew.
  ///
  /// In en, this message translates to:
  /// **'Start new ledger'**
  String get setupStartNew;

  /// No description provided for @setupStartNewHint.
  ///
  /// In en, this message translates to:
  /// **'Empty books, filled from your slips'**
  String get setupStartNewHint;

  /// No description provided for @setupImport.
  ///
  /// In en, this message translates to:
  /// **'Import hledger'**
  String get setupImport;

  /// No description provided for @setupImportHint.
  ///
  /// In en, this message translates to:
  /// **'A file from hledger print -O json'**
  String get setupImportHint;

  /// No description provided for @setupNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New ledger'**
  String get setupNewTitle;

  /// No description provided for @setupCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get setupCurrency;

  /// No description provided for @setupAccountsHint.
  ///
  /// In en, this message translates to:
  /// **'Sub-accounts appear as you record entries'**
  String get setupAccountsHint;

  /// No description provided for @setupCreate.
  ///
  /// In en, this message translates to:
  /// **'Create ledger'**
  String get setupCreate;

  /// No description provided for @setupSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get setupSourceTitle;

  /// No description provided for @setupChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get setupChooseFile;

  /// No description provided for @setupChooseAnother.
  ///
  /// In en, this message translates to:
  /// **'Choose another file'**
  String get setupChooseAnother;

  /// No description provided for @setupPickHint.
  ///
  /// In en, this message translates to:
  /// **'Pick the file made by hledger print -O json'**
  String get setupPickHint;

  /// No description provided for @setupFile.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get setupFile;

  /// No description provided for @setupSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get setupSize;

  /// No description provided for @setupFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get setupFoundTitle;

  /// No description provided for @setupTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get setupTransactions;

  /// No description provided for @setupRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get setupRange;

  /// No description provided for @setupAllBalanced.
  ///
  /// In en, this message translates to:
  /// **'All balanced'**
  String get setupAllBalanced;

  /// No description provided for @setupUnbalanced.
  ///
  /// In en, this message translates to:
  /// **'{count} don\'t balance'**
  String setupUnbalanced(int count);

  /// No description provided for @setupImportAction.
  ///
  /// In en, this message translates to:
  /// **'Import {count}'**
  String setupImportAction(int count);

  /// No description provided for @setupUnreadable.
  ///
  /// In en, this message translates to:
  /// **'Can\'t read {count} entries in this file'**
  String setupUnreadable(int count);

  /// No description provided for @setupFileFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the file'**
  String get setupFileFailed;

  /// No description provided for @setupSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t set up the ledger'**
  String get setupSaveFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
