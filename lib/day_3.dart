import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(3).readAsLinesSync();

final _logger = Logger('Day3');

void day3Part1() {
  var total = 0;
  for (final rucksack in input) {
    final halfway = rucksack.length ~/ 2;
    final set1 = rucksack.substring(0, halfway).split('').toSet();
    final set2 = rucksack.substring(halfway).split('').toSet();

    final shared = set1.intersection(set2).first;
    total += getPriority(shared.codeUnits.first);
  }

  _logger.info('Total Priority: $total');
}

void day3Part2() {
  var total = 0;
  final group = <String>[];
  for (final rucksack in input) {
    group.add(rucksack);

    if (group.length < 3) {
      continue;
    }

    final first = group.first.split('').toSet();
    final second = group.second.split('').toSet();
    final last = group.last.split('').toSet();

    final badge = first.intersection(second).intersection(last).first;

    total += getPriority(badge.codeUnits.first);

    group.clear();
  }

  _logger.info('Total Priority: $total');
}

int getPriority(final int rune) => switch (rune) {
      > 96 => rune - 96, // lowercase
      _ => rune - 38, // uppercase
    };

extension on List<String> {
  String get second => this[1];
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day3Part1();
  day3Part2();
}
