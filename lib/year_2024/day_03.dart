import 'dart:async';

import 'package:aoc/solution.dart';

final class Aoc2024Day3 extends Solution<num, num, List<(num, num)>> {
  const Aoc2024Day3();

  @override
  FutureOr<num> first(List<(num, num)> input) {
    return input
        .fold(0.0, (previous, next) => previous + (next.$1 * next.$2))
        .toInt();
  }

  static final _findMulOperationRegex = RegExp(r'mul\(\d{1,3},\d{1,3}\)');

  @override
  List<(num, num)> inputParser(String str) {
    List<(num, num)> validInputs = [];
    final matches = _findMulOperationRegex.allMatches(str.trim());

    for (final match in matches) {
      final inputs =
          RegExp(r'\d{1,3}').allMatches(match[0]!).map((it) => it[0]!);
      validInputs.add((int.parse(inputs.first), int.parse(inputs.last)));
    }

    return validInputs;
  }

  @override
  FutureOr<num> second(List<(num, num)> input) {
    return 0;
  }
}
