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
  List<List<int>> primaryInputParser(String str) {
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
    int safeReports = 0;

    for (final report in input) {
      if (isReportSafeWithDampener(report)) safeReports += 1;
    }

    return safeReports;
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
    for (int i = 1; i < report.length; i++) {
      final result = (report[i] - report[i - 1]);
      final didAscensionOrderBreak =
          isDecreasing ? !result.isNegative : result.isNegative;
      if (didAscensionOrderBreak || result == 0) return false;

      final isSafe = (isDecreasing ? result.abs() : result) <= _reportTolerance;
      if (!isSafe) return false;
    }

    return true;
  }

  @visibleForTesting
  @protected
  bool isReportSafeWithDampener(List<int> report) {
    if (isReportSafe(report)) return true;

    final list = report.toList();
    for (int i = 0; i < list.length; i++) {
      final newReport = list.toList()..removeAt(i);
      if (isReportSafe(newReport)) return true;
    }

    return false;
  }
}
