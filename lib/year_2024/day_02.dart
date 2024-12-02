import 'dart:async';

import 'package:meta/meta.dart';

import '../solution.dart';

final class Aoc2024Day2 extends Solution<int, int, List<List<int>>> {
  const Aoc2024Day2();

  static final _reportTolerance = 3;

  @override
  FutureOr<int> first(List<List<int>> input) {
    int safeReports = 0;

    for (final report in input) {
      if (isReportSafe(report)) safeReports += 1;
    }

    return safeReports;
  }

  @override
  List<List<int>> inputParser(String str) {
    final input = str.trim().split('\n');
    List<List<int>> reports = [];
    for (final reportStr in input) {
      final trimmedReport = reportStr
          .split(' ')
          .map((element) => int.tryParse(element))
          .toList()
        ..removeWhere((level) => level == null);
      reports.add(List.castFrom(trimmedReport));
    }

    return reports;
  }

  @override
  FutureOr<int> second(List<List<int>> input) {
    return 0;
  }

  @visibleForTesting
  @protected
  bool isReportDecreasing(List<int> report) {
    return (report[1] - report[0]).isNegative;
  }

  @visibleForTesting
  @protected
  bool isReportSafe(List<int> report) {
    final isDecreasing = isReportDecreasing(report);
    bool? isReportSafe;

    if (isDecreasing) {
      for (int i = 1; i < report.length; i++) {
        if (isReportSafe == false) {
          break; // quit the loop if marked unsafe
        }

        final result = (report[i] - report[i - 1]);
        if (!result.isNegative || result == 0) {
          isReportSafe = false;
          break;
        }

        isReportSafe = result.abs() <= _reportTolerance;
      }
    } else {
      for (int i = 1; i < report.length; i++) {
        if (isReportSafe == false) {
          break; // quit the loop if marked unsafe
        }

        final result = (report[i] - report[i - 1]);
        if (result.isNegative || result == 0) {
          isReportSafe = false;
          break;
        }
        isReportSafe = result <= _reportTolerance;
      }
    }

    return isReportSafe ?? false;
  }
}
