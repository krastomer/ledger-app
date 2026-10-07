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
  String get settingsHideOnLaunchHint => 'ซ่อนยอดเงินหน้าหลักตอนเปิดแอป';

  @override
  String get settingsShowZeroBalance => 'แสดงบัญชียอดเป็นศูนย์';

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
  String get bootOpening => 'กำลังเปิดสมุดบัญชี';
}
