import 'package:aoc/year_2024/day_01.dart';
import 'package:test/test.dart';

void main() {
  final aoc = Aoc2024Day1();
  group('AOC day 1 tests', () {
    test('Find distance between locations from input string', () {
      final input = '''
3   4
4   3
2   5
1   3
3   9
3   3
''';

      final distance = aoc(input, 0);
      expect(distance, 11, reason: 'distance sum from aoc example');
    });

    test('Calculate similarity score between the location lists', () {
      final input = '''
3   4
4   3
2   5
1   3
3   9
3   3
''';

      final similarityScore = aoc(input, 1);
      expect(similarityScore, 31);
    });
  });
}
