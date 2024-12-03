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
  List<(num, num)> inputParser(String str) {
    final input = str.trim();
    List<String> instructions = [];
    bool foundOpeningChar = false;
    String mulOperation = '';
    for (int i = 0; i < input.length; i++) {
      if (input[i] == 'm') {
        final collect = [input[i], input[i + 1], input[i + 2]].join();
        if (collect == 'mul') {
          i = i + 2;
          instructions.add('mul');
          continue;
        }
      }

      if (foundOpeningChar && RegExp('(\\d+|,)').hasMatch(input[i])) {
        mulOperation += input[i];
        continue;
      } else if (foundOpeningChar && !RegExp('(\\d+|,)').hasMatch(input[i])) {
        foundOpeningChar = false;
        if (input[i] == ')' &&
            RegExp(r'(\d{1,3},\d{1,3})').hasMatch(mulOperation)) {
          if (mulOperation.isNotEmpty) instructions.add(mulOperation);
        }

        mulOperation = '';
        continue;
      }

      if (input[i] == '(' && instructions.last == 'mul') {
        foundOpeningChar = true;
        continue;
      }

      instructions.add(input[i]);
    }

    List<(num, num)> validInstructions = [];
    for (int i = 1; i < instructions.length; i++) {
      if (RegExp('(\\d+|,)').hasMatch(instructions[i]) &&
          !RegExp('(\\d{4,},)').hasMatch(instructions[i]) &&
          instructions[i - 1] == 'mul') {
        final inputs = instructions[i].split(',');
        validInstructions
            .add((int.parse(inputs.first), int.parse(inputs.last)));
      }
    }

    return validInstructions;
  }

  @override
  FutureOr<num> second(List<(num, num)> input) {
    return 0;
  }
}
