import 'package:args/args.dart';
import 'package:dart/day_1.dart';
import 'package:dart/day_10.dart';
import 'package:dart/day_11.dart';
import 'package:dart/day_12.dart';
import 'package:dart/day_13.dart';
import 'package:dart/day_14.dart';
import 'package:dart/day_15.dart';
import 'package:dart/day_16.dart';
import 'package:dart/day_17.dart';
import 'package:dart/day_18.dart';
import 'package:dart/day_19.dart';
import 'package:dart/day_2.dart';
import 'package:dart/day_20.dart';
import 'package:dart/day_21.dart';
import 'package:dart/day_22.dart';
import 'package:dart/day_23.dart';
import 'package:dart/day_24.dart';
import 'package:dart/day_3.dart';
import 'package:dart/day_4.dart';
import 'package:dart/day_5.dart';
import 'package:dart/day_6.dart';
import 'package:dart/day_7.dart';
import 'package:dart/day_8.dart';
import 'package:dart/day_9.dart';
import 'package:dart/logging.dart';
import 'package:logging/logging.dart';

void main(final List<String> arguments) {
  final parser = ArgParser() //
    ..addOption(
      'day',
      abbr: 'd',
      mandatory: true,
      help: 'Day to run',
      valueHelp: '1',
      allowed: Iterable.generate(24, (final i) => '${i + 1}'),
      hide: false,
    )
    ..addOption(
      'part',
      abbr: 'p',
      mandatory: false,
      help: 'Part 1 or 2',
      valueHelp: '1',
      allowed: ['1', '2'],
      hide: false,
    );
  final args = parser.parse(arguments);
  final day = int.parse(args['day'] as String);
  final partStr = args['part'] as String?;
  final part = partStr == null ? 1 : int.parse(partStr);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  functions[day - 1][part - 1]();
}

final functions = [
  [day1Part1, day1Part2],
  [day2Part1, day2Part2],
  [day3Part1, day3Part2],
  [day4Part1, day4Part2],
  [day5Part1, day5Part2],
  [day6Part1, day6Part2],
  [day7Part1, day7Part2],
  [day8Part1, day8Part2],
  [day9Part1, day9Part2],
  [day10Part1, day10Part2],
  [day11Part1, day11Part2],
  [day12Part1, day12Part2],
  [day13Part1, day13Part2],
  [day14Part1, day14Part2],
  [day15Part1, day15Part2],
  [day16Part1, day16Part2],
  [day17Part1, day17Part2],
  [day18Part1, day18Part2],
  [day19Part1, day19Part2],
  [day20Part1, day20Part2],
  [day21Part1, day21Part2],
  [day22Part1, day22Part2],
  [day23Part1, day23Part2],
  [day24Part1, day24Part2],
];
