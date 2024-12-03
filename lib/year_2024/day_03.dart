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
  List<(num, num)> primaryInputParser(String str) {
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
  List<(num, num)> secondaryInputParser(String str) {
    final trimmedInput = _trimInputForDoAndDontRule(str);
    return super.secondaryInputParser(trimmedInput);
  }

  @override
  FutureOr<num> second(List<(num, num)> input) {
    return input
        .fold(0.0, (previous, next) => previous + (next.$1 * next.$2))
        .toInt();
  }

  String _trimInputForDoAndDontRule(String input) {
    final negativePositiveMatches =
        RegExp("(?<negative>don't())|(?<positive>do())").allMatches(input);

    if (negativePositiveMatches.isEmpty) return input;

    (int? start, int? end)? removeRange;
    for (final m in negativePositiveMatches) {
      if (m.namedGroup('negative') != null && removeRange?.$1 != null) {
        removeRange = (removeRange!.$1, m.start);
        final before = input.substring(0, removeRange.$1);
        final after = _trimInputForDoAndDontRule(
            input.substring(removeRange.$2 ?? removeRange.$1!, input.length));
        return '$before$after';
      }

      if (m.namedGroup('negative') != null) {
        removeRange = (m.start, null);
        continue;
      }

      if (m.namedGroup('positive') != null && removeRange?.$1 != null) {
        removeRange = (removeRange!.$1, m.end);

        final before = input.substring(0, removeRange.$1);
        final after = _trimInputForDoAndDontRule(
            input.substring(removeRange.$2 ?? removeRange.$1!, input.length));
        return '$before$after';
      }
    }

    // no do method till end of string
    if (removeRange?.$1 != null && removeRange?.$2 == null) return '';

    return input;
  }
}
