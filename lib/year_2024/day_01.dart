import 'dart:async';

import 'package:aoc/solution.dart';

final class Aoc2024Day1 extends Solution<int, int, (List<int>, List<int>)> {
  const Aoc2024Day1();

  @override
  FutureOr<int> first((List<int>, List<int>) input) {
    return _calculateDistanceBetweenLocationLists(input.$1, input.$2).toInt();
  }

  @override
  FutureOr<int> second((List<int>, List<int>) input) {
    return _calculateSimilarityScore(input.$1, input.$2).toInt();
  }

  @override
  (List<int>, List<int>) primaryInputParser(String str) {
    final input = str.trim().split('\n');

    final a = List.filled(input.length, 0);
    final b = List.filled(input.length, 0);

    for (int i = 0; i < input.length; i++) {
      final item = input[i];
      final inputs =
          item.split(RegExp('\\s+')).map((element) => int.parse(element));
      a[i] = inputs.first;
      b[i] = inputs.last;
    }

    return (a, b);
  }

  num _calculateDistanceBetweenLocationLists(List<int> a, List<int> b) {
    if (a.length != b.length) {
      throw ArgumentError(
          'Length of a: ${a.length} doesn\'t match b: ${b.length}');
    }

    a.sort();
    b.sort();

    final distances = List.filled(a.length, 0);
    for (int i = 0; i < a.length; i++) {
      distances[i] = (b[i] - a[i]).abs();
    }

    return distances.fold(0, (previous, next) => previous + next);
  }

  num _calculateSimilarityScore(List<int> a, List<int> b) {
    if (a.length != b.length) {
      throw ArgumentError(
          'Length of a: ${a.length} doesn\'t match b: ${b.length}');
    }

    final similarities = List.filled(a.length, 0);
    for (int i = 0; i < a.length; i++) {
      similarities[i] = a[i] * (b.where((item) => item == a[i]).length);
    }

    return similarities.fold(0, (previous, next) => previous + next);
  }
}
