import 'package:test/test.dart';

import '../bin/aoc_1.dart';

void main() {
  group('AOC day 1 tests', () {
    test('Ensure valid inputs are passed to the lists', () {
      expect(
        () => findDistanceBetweenLocationLists([1, 2, 3, 4, 5], [1, 2, 3]),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message,
            'Argument error is thrown from list lengths not matching, matcher',
            'Length of a: 5 doesn\'t match b: 3')),
      );
    });

    test('Ensure the list are correctly sorted', () {
      final a = [5, 2, 4, 6, 1];
      final b = [3, 4, 3, 5, 8];

      findDistanceBetweenLocationLists(a, b);

      expect(a, [1, 2, 4, 5, 6]);
      expect(b, [3, 3, 4, 5, 8]);
    });

    test('Return distance from two location lists', () {
      final distance = findDistanceBetweenLocationLists(
          [3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3]);

      expect(distance, 11, reason: 'Distance in example problem is 11');
    });

    test('strip list from string input', () {
      final input = '''
3   4
4   3
2   5
1   3
3   9
3   3
'''
          .trim()
          .split('\n');

      expect(input.length, 6, reason: 'Input string contains 6 input list');

      final a = List.filled(input.length, 0);
      final b = List.filled(input.length, 0);

      for (int i = 0; i < input.length; i++) {
        final item = input[i];
        final inputs =
            item.split(RegExp('\\s+')).map((element) => int.parse(element));
        a[i] = inputs.first;
        b[i] = inputs.last;
      }

      expect(a, [3, 4, 2, 1, 3, 3]);
      expect(b, [4, 3, 5, 3, 9, 3]);
    });

    test('Find distance between locations from input string', () {
      final input = '''
3   4
4   3
2   5
1   3
3   9
3   3
''';

      final distance = findDistanceInLocations(input);
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

      final similarityScore = similarityScoreInLocations(input);

      expect(similarityScore, 31);
    });
  });
}


