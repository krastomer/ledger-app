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
  String get homeTitle => 'ภาพรวม';

  @override
  String get hideAmounts => 'ซ่อนยอดเงิน';

  @override
  String get showAmounts => 'แสดงยอดเงิน';

  @override
  String get netWorth => 'มูลค่าสุทธิ';

  @override
  String get seeAccounts => 'ดูบัญชี';

  @override
  String get assets => 'สินทรัพย์';

  @override
  String get liabilities => 'หนี้สิน';

  @override
  String reviewBannerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count รายการรอตรวจ',
    );
    return '$_temp0';
  }

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
  String get reportsTitle => 'รายงาน';

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
}
