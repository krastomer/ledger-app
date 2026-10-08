// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'บัญชี';

  @override
  String get navHome => 'หน้าหลัก';

  @override
  String get navTransactions => 'รายการ';

  @override
  String get navInbox => 'รอตรวจ';

  @override
  String get navSettings => 'ตั้งค่า';

  @override
  String get hideAmounts => 'ซ่อนยอดเงิน';

  @override
  String get showAmounts => 'แสดงยอดเงิน';

  @override
  String get netWorth => 'มูลค่าสุทธิ';

  @override
  String get assets => 'สินทรัพย์';

  @override
  String get liabilities => 'หนี้สิน';

  @override
  String get income => 'รายรับ';

  @override
  String get expenses => 'รายจ่าย';

  @override
  String get net => 'คงเหลือ';

  @override
  String get seeReports => 'ดูรายงาน';

  @override
  String get topSpending => 'ใช้จ่ายมากสุด';

  @override
  String get recent => 'ล่าสุด';

  @override
  String get seeAll => 'ดูทั้งหมด';

  @override
  String get noTransactions => 'ยังไม่มีรายการ';

  @override
  String get loadFailed => 'โหลดข้อมูลไม่สำเร็จ';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get comingSoon => 'เร็วๆ นี้';

  @override
  String get accountsTitle => 'บัญชี';

  @override
  String get settingsGeneral => 'ทั่วไป';

  @override
  String get settingsLanguage => 'ภาษา';

  @override
  String get settingsYearFormat => 'การแสดงปี';

  @override
  String get languageThai => 'ไทย';

  @override
  String get languageEnglish => 'English';

  @override
  String yearBuddhistEra(int year) {
    return 'พ.ศ. $year';
  }

  @override
  String yearCommonEra(int year) {
    return 'ค.ศ. $year';
  }

  @override
  String get settingsSaveFailed => 'บันทึกการตั้งค่าไม่สำเร็จ';

  @override
  String get netIncome => 'สุทธิ';

  @override
  String get previousMonth => 'เดือนก่อน';

  @override
  String get nextMonth => 'เดือนถัดไป';

  @override
  String get noTransactionsThisMonth => 'เดือนนี้ยังไม่มีรายการ';

  @override
  String get searchTransactions => 'ค้นหารายการ';

  @override
  String get clearSearch => 'ล้างคำค้นหา';

  @override
  String get filterPending => 'รอตรวจ';

  @override
  String get today => 'วันนี้';

  @override
  String get slipAttached => 'มีสลิป';

  @override
  String get filterHint => 'กรอง';

  @override
  String get noMatches => 'ไม่พบ';

  @override
  String get noMatchingTransactions => 'ไม่พบรายการที่ตรงกัน';

  @override
  String get netLabel => 'สุทธิ';

  @override
  String get generalCategory => 'ทั่วไป';

  @override
  String get leftOver => 'คงเหลือ';

  @override
  String subcategoriesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count หมวดย่อย',
    );
    return '$_temp0';
  }

  @override
  String entriesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count รายการ',
    );
    return '$_temp0';
  }

  @override
  String get allocationItem => 'รายการ';

  @override
  String get allocationShare => 'สัดส่วน';

  @override
  String get allocationAmount => 'ยอด';

  @override
  String shareOfParent(String percent, String parent) {
    return '$percent ของ$parent';
  }

  @override
  String accountsAsOf(String date) {
    return 'ณ $date';
  }

  @override
  String get balanceView => 'ยอดคงเหลือ';

  @override
  String get monthChangeView => 'เปลี่ยนแปลงเดือนนี้';

  @override
  String expandAccount(String name) {
    return 'ขยาย $name';
  }

  @override
  String collapseAccount(String name) {
    return 'ย่อ $name';
  }

  @override
  String get noAccounts => 'ยังไม่มีบัญชี';

  @override
  String itemsNeedReview(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'รายการรอตรวจ',
    );
    return '$_temp0';
  }

  @override
  String get openAction => 'เปิด';

  @override
  String get hideAction => 'ซ่อน';

  @override
  String get showAction => 'แสดง';

  @override
  String get back => 'กลับ';

  @override
  String get filterPendingFlag => '--รอตรวจ';

  @override
  String get filterSlipFlag => '--มีสลิป';

  @override
  String get registerTitle => 'รายการเดินบัญชี';

  @override
  String shownCount(int count) {
    return 'แสดง $count รายการ';
  }

  @override
  String get balanceSheetTitle => 'งบดุล';

  @override
  String get incomeStatementTitle => 'งบกำไรขาดทุน';

  @override
  String savedPercent(String percent) {
    return 'ออมได้ $percent';
  }

  @override
  String get configFileTitle => '~/.ledgerrc';

  @override
  String get dataStaysOnDevice => 'ข้อมูลทั้งหมดอยู่ในเครื่องนี้';

  @override
  String get dailySpendTitle => 'ใช้จ่ายรายวัน';

  @override
  String dailySpendCalendar(String month) {
    return 'ปฏิทินรายจ่ายรายวัน $month';
  }

  @override
  String dailyAverage(String amount) {
    return 'เฉลี่ย $amount/วัน';
  }

  @override
  String get dailyPeak => 'สูงสุด';

  @override
  String get settingsDisplay => 'การแสดงผล';

  @override
  String get settingsHideOnLaunch => 'ซ่อนยอดตอนเปิดแอป';

  @override
  String get settingsHideOnLaunchHint => 'ยอดเงินหน้าหลักจะถูกซ่อนไว้ก่อน';

  @override
  String get settingsShowJournal => 'แสดงสมุดรายวัน';

  @override
  String get settingsShowJournalHint => 'ข้อความ hledger ในหน้ารายการ';

  @override
  String get settingsHiddenAccounts => 'บัญชีที่ซ่อน';

  @override
  String get settingsHomeCards => 'การ์ดหน้าหลัก';

  @override
  String get settingsStorage => 'การจัดเก็บ';

  @override
  String get settingsKeepSlipImages => 'เก็บรูปสลิป';

  @override
  String get settingsKeepSlipImagesHint => 'false = เก็บเฉพาะข้อมูลที่อ่านได้';

  @override
  String get settingsLastBackup => 'สำรองล่าสุด';

  @override
  String get backupNever => 'ยังไม่เคย';

  @override
  String get backUpAction => 'สำรองข้อมูล';

  @override
  String get restoreAction => 'กู้คืน';

  @override
  String get restoreReplacesData => 'การกู้คืนจะแทนที่ข้อมูลทั้งหมด';

  @override
  String get bootHeader => 'ledger · tty0';

  @override
  String get bootOnDevice => 'ในเครื่อง';

  @override
  String bootOpened(int count) {
    return 'เปิดสมุดบัญชี: $count รายการ';
  }

  @override
  String bootParsed(String from, String to) {
    return 'อ่านข้อมูล $from..$to';
  }

  @override
  String get bootBalanced => 'ตรวจยอดสมดุลแล้ว';

  @override
  String bootUnbalanced(int count) {
    return '$count รายการยอดไม่สมดุล';
  }

  @override
  String bootOcr(String engine) {
    return 'เริ่ม OCR ($engine)';
  }

  @override
  String get bootFailed => 'เปิดสมุดบัญชีไม่ได้';

  @override
  String get nothingToReview => 'ไม่มีรายการรอตรวจ';

  @override
  String get continueAction => 'ไปต่อ';

  @override
  String get newSlipsTitle => 'สลิปใหม่';

  @override
  String get newSlipsHint => 'เลือกรูปสลิปจากคลังรูป ระบบจะอ่านในเครื่องนี้';

  @override
  String get pickSlipsAction => 'เลือกสลิป';

  @override
  String get queueTitle => 'คิว';

  @override
  String openCount(int count) {
    return 'ค้าง $count';
  }

  @override
  String get reviewTagPending => 'ยืนยัน';

  @override
  String get reviewTagDuplicate => 'ซ้ำ?';

  @override
  String get reviewTagUncategorized => 'ไม่มีหมวด';

  @override
  String get duplicateHint => 'วันและรายการบัญชีเหมือนอีกรายการ';

  @override
  String get confirmAction => 'ยืนยัน';

  @override
  String get keepAction => 'เก็บไว้';

  @override
  String get dropOneAction => 'ลบซ้ำ';

  @override
  String get categorizeAction => 'ใส่หมวด';

  @override
  String get categoryTitle => 'หมวด';

  @override
  String get accountTitle => 'บัญชี';

  @override
  String get slipsReadOnDevice =>
      'อ่านสลิปในเครื่อง ไม่มีข้อมูลออกจากเครื่องนี้';

  @override
  String get changeFailed => 'บันทึกการเปลี่ยนแปลงไม่สำเร็จ';

  @override
  String get photosFailed => 'เปิดคลังรูปไม่ได้';

  @override
  String get transactionTitle => 'รายการ';

  @override
  String get statusCleared => 'เคลียร์แล้ว';

  @override
  String get kindExpense => 'รายจ่าย';

  @override
  String get kindIncome => 'รายรับ';

  @override
  String get kindTransfer => 'โอน';

  @override
  String codeLabel(String code) {
    return 'รหัส $code';
  }

  @override
  String get postingsTitle => 'รายการบัญชี';

  @override
  String get balanced => 'สมดุล';

  @override
  String get notBalanced => 'ไม่สมดุล';

  @override
  String get slipTitle => 'สลิป';

  @override
  String get refLabel => 'อ้างอิง';

  @override
  String get journalEntryTitle => 'สมุดรายวัน';

  @override
  String get copyAction => 'คัดลอก';

  @override
  String get deleteAction => 'ลบ';

  @override
  String get deleteTransaction => 'ลบรายการ';

  @override
  String get copied => 'คัดลอกแล้ว';

  @override
  String get deleteConfirm => 'ลบรายการนี้?';

  @override
  String get transactionNotFound => 'ไม่พบรายการนี้แล้ว';

  @override
  String get closeAction => 'ปิด';

  @override
  String slipProgress(int index, int count) {
    return 'สลิป $index จาก $count';
  }

  @override
  String get slipKindTransfer => 'โอน';

  @override
  String get slipKindPayment => 'จ่ายบิล';

  @override
  String get slipKindBuy => 'ซื้อ';

  @override
  String get slipKindSell => 'ขาย';

  @override
  String get amountLabel => 'ยอด';

  @override
  String get dateLabel => 'วันที่';

  @override
  String get engineLabel => 'ระบบ';

  @override
  String get dupLabel => 'ซ้ำ';

  @override
  String get dupNone => 'ไม่ซ้ำ';

  @override
  String dupFound(String date) {
    return 'บันทึกแล้ว $date';
  }

  @override
  String get fieldsTitle => 'ข้อมูล';

  @override
  String get fromLabel => 'จาก';

  @override
  String get toLabel => 'ถึง';

  @override
  String get feeLabel => 'ค่าฟี';

  @override
  String get notOnSlip => 'ไม่มีในสลิป';

  @override
  String get unclearCheck => 'อ่านไม่ชัด โปรดตรวจ';

  @override
  String get willWriteTitle => 'จะบันทึก';

  @override
  String get hintFromHistory => 'เคยใช้กับผู้รับนี้';

  @override
  String get hintPickCategory => 'เลือกหมวด';

  @override
  String hintFromSlip(String source) {
    return 'จาก $source';
  }

  @override
  String get skipAction => 'ข้าม';

  @override
  String get saveNextAction => 'บันทึกแล้วไปต่อ';

  @override
  String get slipUnreadable => 'อ่านสลิปนี้ไม่ได้';

  @override
  String get slipNoAmount => 'ไม่พบยอดเงินในสลิป';

  @override
  String get readingSlip => 'กำลังอ่านสลิป';

  @override
  String slipsSaved(int count) {
    return 'บันทึก $count สลิป';
  }

  @override
  String get descriptionTitle => 'รายละเอียด';

  @override
  String get viewSlipImage => 'ดูรูปสลิป';

  @override
  String get viewImageAction => 'ดูรูป';

  @override
  String get slipImageMissing => 'ไม่มีรูปสลิปนี้ในเครื่องแล้ว';

  @override
  String get bootOpening => 'กำลังเปิดสมุดบัญชี';

  @override
  String get setupHeader => 'ledger · setup';

  @override
  String get setupTitle => 'ตั้งค่าเริ่มต้น';

  @override
  String get setupStartNew => 'เริ่มสมุดบัญชีใหม่';

  @override
  String get setupStartNewHint => 'สมุดเปล่า เติมจากสลิปของคุณ';

  @override
  String get setupImport => 'นำเข้าจาก hledger';

  @override
  String get setupImportHint => 'ไฟล์จาก hledger print -O json';

  @override
  String get setupNewTitle => 'สมุดบัญชีใหม่';

  @override
  String get setupCurrency => 'สกุลเงิน';

  @override
  String get setupAccountsHint => 'บัญชีย่อยจะเกิดขึ้นเมื่อบันทึกรายการ';

  @override
  String get setupCreate => 'สร้างสมุดบัญชี';

  @override
  String get setupSourceTitle => 'ไฟล์ต้นทาง';

  @override
  String get setupChooseFile => 'เลือกไฟล์';

  @override
  String get setupChooseAnother => 'เลือกไฟล์อื่น';

  @override
  String get setupPickHint => 'เลือกไฟล์ที่ได้จาก hledger print -O json';

  @override
  String get setupFile => 'ไฟล์';

  @override
  String get setupSize => 'ขนาด';

  @override
  String get setupFoundTitle => 'ที่พบ';

  @override
  String get setupTransactions => 'รายการ';

  @override
  String get setupRange => 'ช่วงเวลา';

  @override
  String get setupAllBalanced => 'สมดุลทุกรายการ';

  @override
  String setupUnbalanced(int count) {
    return '$count รายการไม่สมดุล';
  }

  @override
  String setupImportAction(int count) {
    return 'นำเข้า $count';
  }

  @override
  String setupUnreadable(int count) {
    return 'อ่านไม่ได้ $count รายการในไฟล์นี้';
  }

  @override
  String get setupFileFailed => 'เปิดไฟล์ไม่ได้';

  @override
  String setupStep(int step, int total) {
    return 'ขั้นที่ $step/$total';
  }

  @override
  String get setupSettingsTitle => 'ตั้งค่า';

  @override
  String get setupPrivacy => 'ความเป็นส่วนตัว';

  @override
  String get setupChangeLater => 'เปลี่ยนทั้งหมดนี้ภายหลังได้ในการตั้งค่า';

  @override
  String get setupPhotosTitle => 'รูปสลิป';

  @override
  String get setupSyncGallery => 'ซิงก์แกลเลอรี';

  @override
  String get setupSyncGalleryHint => 'หาสลิปใหม่ในคลังรูปของคุณ';

  @override
  String get setupPhotosHint =>
      'รูปไม่ออกจากเครื่อง เปิดหรือปิดภายหลังได้ในการตั้งค่า';

  @override
  String get setupFinish => 'เสร็จสิ้น';

  @override
  String get setupHowTitle => 'ทำงานอย่างไร';

  @override
  String get setupHowSteps =>
      '1. แอปขอสิทธิ์เข้าถึงรูป\n2. รูปใหม่ถูกอ่านด้วย OCR ในเครื่อง\n3. นับสลิปที่เจอ\n4. คุณเลือกว่าจะนำเข้าอันไหน\n5. รูปอื่นจะถูกข้าม';

  @override
  String get setupPhotosScan => 'สแกนรูป';

  @override
  String get setupScanTitle => 'กำลังสแกนคลังรูป';

  @override
  String get setupScanCancel => 'ยกเลิก';

  @override
  String get setupScanScanning => 'กำลังสแกน...';

  @override
  String setupScanLibrary(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'มี $countString รูปในคลังรูป';
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

    return 'อ่านข้อความแล้ว $doneString จาก $totalString';
  }

  @override
  String setupScanFound(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'เจอสลิป $countString ใบ';
  }

  @override
  String get setupScanHint => 'อ่านข้อความในเครื่องนี้ ไม่มีการอัปโหลด';

  @override
  String setupScanReview(int count) {
    return 'ตรวจสอบ $count ใบที่เจอ';
  }

  @override
  String get setupScanNoAccess => 'ไม่มีสิทธิ์เข้าถึงรูปของคุณ';

  @override
  String get setupScanNoAccessHint =>
      'อนุญาตการเข้าถึงรูปในการตั้งค่าของระบบ แล้วสแกนใหม่จากการตั้งค่า';

  @override
  String get setupScanFailed => 'อ่านคลังรูปไม่ได้';

  @override
  String setupFoundSelected(int selected, int total) {
    return 'เลือก $selected จาก $total';
  }

  @override
  String get setupSelectAll => 'เลือกทั้งหมด';

  @override
  String get setupSelectNone => 'ไม่เลือกเลย';

  @override
  String get setupFoundTransfers => 'โอนเงิน';

  @override
  String get setupFoundPayments => 'ชำระเงิน';

  @override
  String get setupFoundOrders => 'คำสั่งซื้อขาย';

  @override
  String get setupFoundUnsure => 'ไม่แน่ใจ';

  @override
  String get setupFoundNoAmount => 'ดูเหมือนสลิป แต่ไม่มียอด';

  @override
  String get setupFoundInboxHint => 'ไปที่กล่องเข้าเพื่อตรวจสอบ';

  @override
  String setupFoundImport(int count) {
    return 'นำเข้า $count';
  }

  @override
  String get setupFoundSkip => 'ข้าม';

  @override
  String get setupSaveFailed => 'ตั้งค่าสมุดบัญชีไม่ได้';

  @override
  String get settingsRules => 'กฎจัดหมวด';

  @override
  String get rulesTitle => 'กฎจัดหมวด';

  @override
  String get rulesSourceTitle => 'ที่มา';

  @override
  String get rulesFile => 'ไฟล์';

  @override
  String get rulesLoaded => 'โหลดเมื่อ';

  @override
  String get rulesSkipped => 'ข้าม';

  @override
  String get rulesNone => '(ไม่มี)';

  @override
  String get rulesNoFile => 'ยังไม่มีไฟล์กฎ';

  @override
  String rulesLoadedCount(int count) {
    return 'โหลดแล้ว $count กฎ · ดูหรือเปลี่ยนไฟล์';
  }

  @override
  String rulesCount(int count) {
    return 'โหลดแล้ว $count';
  }

  @override
  String get rulesViewOnly => 'ดูได้อย่างเดียว · แก้ที่ไฟล์ แล้วเปลี่ยนไฟล์';

  @override
  String get rulesReplaceNote => 'ไฟล์ใหม่จะแทนที่ทุกกฎด้านบน';

  @override
  String get rulesFirstMatch => 'กฎที่ตรงก่อนชนะ ไล่จากบนลงล่าง';

  @override
  String get rulesReplaceAction => 'เปลี่ยนไฟล์';

  @override
  String get rulesChooseAction => 'เลือกไฟล์';

  @override
  String get rulesLoadFailed => 'อ่านกฎที่บันทึกไว้ไม่ได้';

  @override
  String get rulesFileFailed => 'เปิดไฟล์ไม่ได้';

  @override
  String get rulesNoneFound => 'ไม่พบกฎในไฟล์นี้';

  @override
  String get rulesSaveFailed => 'บันทึกกฎไม่สำเร็จ';

  @override
  String rulesSkippedLine(int line) {
    return 'ข้ามบรรทัด $line';
  }

  @override
  String get rulesReasonBadRegex => 'regex ไม่ถูกต้อง';

  @override
  String get rulesReasonMissingAccount => 'ไม่มีบรรทัด account2';

  @override
  String get rulesReasonUnknownField => 'ไม่รู้จักฟิลด์';

  @override
  String get rulesReasonUnknownDirective => 'ไม่รู้จักคำสั่ง';

  @override
  String get setupRulesFileTitle => 'ไฟล์กฎ';

  @override
  String get setupRulesOptional => 'ไม่บังคับ';

  @override
  String get setupRulesFoundTitle => 'กฎที่พบ';

  @override
  String get setupRulesFormatTitle => 'รูปแบบไฟล์ · สไตล์ hledger';

  @override
  String get setupRulesHintViewOnly => 'ในแอปดูกฎได้อย่างเดียว';

  @override
  String get setupRulesHintEdit => 'ถ้าจะแก้ ให้แก้ที่ไฟล์แล้วเปลี่ยนไฟล์';

  @override
  String get setupRulesHintOrder =>
      'กฎที่ตรงก่อนชนะ · หมวดที่ตั้งเองไม่ถูกเขียนทับ';

  @override
  String get setupRulesSkip => 'ข้าม';

  @override
  String setupRulesImport(int count) {
    return 'นำเข้า $count กฎ';
  }

  @override
  String setupScanToCheck(int count) {
    return '$count รูปที่ต้องตรวจ';
  }

  @override
  String get setupAlbumsHeading =>
      'เลือกที่ที่คุณเก็บสลิป · แต่ละเครื่องไม่เหมือนกัน';

  @override
  String get setupAlbumSuggested => 'แนะนำ';

  @override
  String setupAlbumPhotos(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString รูป';
  }

  @override
  String get setupAlbumRecentsHint => 'ทุกรูป ช้ากว่า';

  @override
  String get setupAlbumScreenshotsHint => 'อัลบั้มของระบบ';

  @override
  String get setupAlbumSuggestedHint => 'ชื่อคล้ายแอปธนาคาร';

  @override
  String get setupLookBack => 'ย้อนหลัง';

  @override
  String get setupLookBack30 => '30 วัน';

  @override
  String get setupLookBack90 => '90 วัน';

  @override
  String get setupLookBackAll => 'ทั้งหมด';

  @override
  String setupNothingPicked(String period) {
    return 'ไม่ได้เลือก: ใช้ Recents ย้อนหลัง $period';
  }

  @override
  String get setupLimitedAccess => 'เข้าถึงจำกัด · แสดงเฉพาะรูปที่คุณแชร์ให้';

  @override
  String get setupSelectMore => 'เลือกเพิ่ม';

  @override
  String get setupAlbumsLoading => 'กำลังอ่านอัลบั้ม...';

  @override
  String get setupAlbumsFailed => 'อ่านอัลบั้มไม่ได้';
}
