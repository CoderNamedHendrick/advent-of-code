import 'dart:io';

import 'package:args/args.dart';
import 'solutions.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addOption(
      'year',
      abbr: 'y',
      help: 'Year selection',
      valueHelp: 'value between 2015-2023',
      mandatory: true,
    )
    ..addOption(
      'day',
      abbr: 'd',
      help: 'Day selection',
      valueHelp: 'value between 1-25',
      mandatory: true,
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart aoc.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) async {
  final argParser = buildParser();

  try {
    final results = argParser.parse(arguments);
    final (year, day) = (
      int.parse(results['year'] as String),
      int.parse(results['day'] as String),
    );

    final solutionData = solutions[year]?[day];
    if (solutionData == null) {
      print('Solution data not found for $year, day $day');
    }

    final strInput = await File(solutionData!.dataPath).readAsString();
    final first = await solutionData.solution(strInput, 0);
    final second = await solutionData.solution(strInput, 1);

    print('$year day $day first: $first');
    print('$year day $day second: $second');
  } catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e);
    printUsage(argParser);
  }
}
