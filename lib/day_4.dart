import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(4).readAsLinesSync();

final _logger = Logger('Day4');

void day4Part1() {
  var count = 0;

  for (final assignments in input) {
    final [firstAssignment, secondAssignment] = assignments.split(',');

    final [partOneFA, partTwoFA] = firstAssignment.split('-');
    final first = int.parse(partOneFA);
    final second = int.parse(partTwoFA);

    final [partOneSA, partTwoSA] = secondAssignment.split('-');
    final third = int.parse(partOneSA);
    final fourth = int.parse(partTwoSA);

    if ((first <= third && fourth <= second) || (third <= first && second <= fourth)) {
      count++;
    }
  }

  _logger.info('Contained: $count');
}

void day4Part2() {
  var count = 0;

  for (final assignments in input) {
    final [firstAssignment, secondAssignment] = assignments.split(',');

    final [partOneFA, partTwoFA] = firstAssignment.split('-');
    final first = int.parse(partOneFA);
    final second = int.parse(partTwoFA);

    final [partOneSA, partTwoSA] = secondAssignment.split('-');
    final third = int.parse(partOneSA);
    final fourth = int.parse(partTwoSA);

    if ( // touching
        first == third ||
            first == fourth ||
            second == third ||
            second == fourth ||
            // contained
            (first < third && fourth < second) ||
            (third < first && second < fourth) ||
            // partial overlap
            (first < third && third < second && second < fourth) ||
            (third < first && first < fourth && fourth < second)) {
      count++;
    }
  }

  _logger.info('Contained: $count');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day4Part1();
  day4Part2();
}
