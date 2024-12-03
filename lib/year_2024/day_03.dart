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

  @override
  List<(num, num)> primaryInputParser(String str) {
    List<(num, num)> validInputs = [];
    final matches = RegExp(r'mul\(\d{1,3},\d{1,3}\)').allMatches(str.trim());

    for (final match in matches) {
      final inputs =
          RegExp(r'\d{1,3}').allMatches(match[0]!).map((it) => it[0]!);
      validInputs.add((int.parse(inputs.first), int.parse(inputs.last)));
    }

    return validInputs;
  }

  @override
  List<(num, num)> secondaryInputParser(String str) {
    final trimmedInput = _trimInputForRule(str);
    return super.secondaryInputParser(trimmedInput);
  }

  @override
  FutureOr<num> second(List<(num, num)> input) {
    return input
        .fold(0.0, (previous, next) => previous + (next.$1 * next.$2))
        .toInt();
  }

  String _trimInputForRule(String input) {
    final negativePositiveMatches =
        RegExp("(?<negative>don't())|(?<positive>do())").allMatches(input);

    if (negativePositiveMatches.isEmpty) return input;

    (int? start, int? end)? removeRange;
    for (final m in negativePositiveMatches) {
      if (m.namedGroup('negative') != null) {
        if (removeRange?.$1 != null) {
          removeRange = (removeRange!.$1, m.start);
          return _newTrimInput(removeRange, input);
        }

        removeRange = (m.start, null);
        continue;
      }

      if (m.namedGroup('positive') != null && removeRange?.$1 != null) {
        removeRange = (removeRange!.$1, m.end);
        return _newTrimInput(removeRange, input);
      }
    }

    // no do method till end of string
    if (removeRange?.$1 != null && removeRange?.$2 == null) return '';

    return input;
  }

  String _newTrimInput((int? start, int? end) range, String input) {
    return input.substring(0, range.$1!) +
        _trimInputForRule(input.substring(range.$2!, input.length));
  }
}
