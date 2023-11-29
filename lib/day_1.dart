import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(1).readAsLinesSync();

final _logger = Logger('Day1');

void day1Part1() {
  var highestTotal = 0;
  var localTotal = 0;
  for (final line in input) {
    if (line.isNotEmpty) {
      localTotal += int.parse(line);
    } else {
      if (highestTotal < localTotal) {
        highestTotal = localTotal;
      }
      localTotal = 0;
    }
  }

  _logger.info('Highest Total Calorie Count: $highestTotal');
}

void day1Part2() {
  final highestTotals = [0, 0, 0];
  var localTotal = 0;
  for (final line in input) {
    if (line.isNotEmpty) {
      localTotal += int.parse(line);
    } else {
      final index = switch (0) {
        _ when highestTotals.first < localTotal => 0,
        _ when highestTotals.second < localTotal => 1,
        _ when highestTotals.last < localTotal => 2,
        _ => -1,
      };
      if (-1 < index) {
        highestTotals.insert(index, localTotal);
        highestTotals.removeLast();
      }
      localTotal = 0;
    }
  }

  final total = highestTotals.reduce((final sum, final val) => sum + val);

  _logger.info('Highest 3 Total Calorie Count: $total');
}

extension on List<int> {
  int get second => this[1];
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day1Part1();
  day1Part2();
}
