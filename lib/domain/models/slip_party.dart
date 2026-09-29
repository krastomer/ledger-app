/// One side of a transfer as printed on a slip.
class SlipParty {
  const SlipParty({required this.name, this.account});

  /// Name as printed, often shortened (`นาย สมชาย ใ.`).
  final String name;

  /// Masked account (`xxx-x-x1234-x`) or biller ID, when the slip shows one.
  final String? account;

  @override
  bool operator ==(Object other) =>
      other is SlipParty && other.name == name && other.account == account;

  @override
  int get hashCode => Object.hash(name, account);

  @override
  String toString() => 'SlipParty($name, $account)';
}
