import 'package:aoc/year_2024/year_2024.dart';
import 'package:test/test.dart';

void main() {
  final aoc = Aoc2024Day3();
  group('Day 3 test suite', () {
    test('scan for valid muls in string', () {
      final input =
          'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      final validInstructions = aoc.inputParser(input);

      expect(validInstructions.length, 4,
          reason: 'there are 4 valid mul instructions occurrences');
    });

    test('test case to handle one input', () {
      final input =
          'xmul(2)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      final validInstructions = aoc.inputParser(input);

      expect(validInstructions.length, 3,
          reason: 'there are 3 valid mul instructions occurrences');
    });

    test('handle case where input is 4 numbers', () {
      final input =
          'xmul(27474,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      expect(aoc.inputParser(input).length, 3,
          reason: 'there are 3 valid instructions');
    });

    test('test sample for task one', () {
      final input =
          'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))';

      expect(aoc.call(input, 0), 161, reason: 'sample prompt result');
    });
  });
}
