String formatPerMille(int perMille) =>
    '${perMille ~/ 10}.${(perMille % 10).abs()}%';
