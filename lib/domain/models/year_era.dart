enum YearEra {
  buddhist,
  gregorian;

  int yearOf(DateTime date) => switch (this) {
    YearEra.buddhist => date.year + 543,
    YearEra.gregorian => date.year,
  };
}
