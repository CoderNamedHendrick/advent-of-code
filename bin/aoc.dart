import 'package:args/args.dart';
import 'aoc_1.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart aoc.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  try {
    dayOneTaskOne();
  } on FormatException catch (_) {
    // Print usage information if an invalid argument was provided.
  }
}
