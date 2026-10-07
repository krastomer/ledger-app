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
}
