enum GalleryLookBack {
  days30(30),
  days90(90),
  all(null);

  const GalleryLookBack(this.days);

  final int? days;

  DateTime? since(DateTime now) {
    final days = this.days;
    return days == null ? null : now.subtract(Duration(days: days));
  }
}
