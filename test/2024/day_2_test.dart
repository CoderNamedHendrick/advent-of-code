import 'package:aoc/year_2024/day_02.dart';
import 'package:test/test.dart';

void main() {
  final aoc = Aoc2024Day2();
  group('Day 2 tasks test suite', () {
    test('parse input string to reports, each row is a report', () {
      final input = '''
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
''';

      final reports = aoc.primaryInputParser(input);

      expect(reports.length, 6, reason: 'there are 6 reports in test input');
      for (final report in reports) {
        expect(report.length, 5, reason: 'there are 5 levels for each report');
      }
    });

    test('check if report is safe', () {
      var report = [7, 6, 4, 2, 1]; // test sample report;

      // check if report is increasing
      expect(aoc.isReportDecreasing(report), true,
          reason: 'for $report has decreasing levels');

      report = [1, 2, 7, 8, 9];

      expect(aoc.isReportDecreasing(report), false,
          reason: 'for $report has increasing levels');
    });

    test(
        'check if report is within tolerance if it is decreasing or increasing',
        () {
      var report = [7, 6, 4, 2, 1]; // test sample report;
      var isWithinTolerance = aoc.isReportSafe(report);

      expect(isWithinTolerance, true,
          reason: 'from the sample, report is safe');

      report = [1, 2, 7, 8, 9];

      expect(aoc.isReportSafe(report), false,
          reason: 'from the sample, report is unsafe');

      report = [1, 3, 2, 4, 5];
      expect(
        aoc.isReportSafe(report),
        false,
        reason:
            'because report is increasing from 1 to 3 but decreasing from 3 to 2',
      );

      report = [8, 6, 4, 4, 1];
      expect(aoc.isReportSafe(report), false,
          reason: '4, 4 is neither increasing nor decreasing');
    });

    test('check how many safe reports exist in sample', () {
      final input = '''
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
''';

      final safeReports = aoc.call(input, 0); // first day task
      expect(safeReports, 2, reason: 'number of safe reports in sample');
    });

    test('check if report is safe with problem dampener', () {
      var report = [1, 3, 2, 4, 5];

      expect(
        aoc.isReportSafeWithDampener(report),
        true,
        reason: 'with problem dampener report should be safe',
      );

      report = [8, 6, 4, 4, 1];

      expect(
        aoc.isReportSafeWithDampener(report),
        true,
        reason: 'with problem dampener report should be safe',
      );
    });

    test('check how many safe reports exist in sample with problem dampener',
        () {
      final input = '''
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
''';

      final safeReports = aoc.call(input, 1); // first day task
      expect(safeReports, 4, reason: 'number of safe reports in sample');
    });
  });
}
