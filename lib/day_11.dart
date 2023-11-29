import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(11).readAsLinesSync();

final _logger = Logger('Day11');

void day11Part1() {
  // TODO: Implement

  _logger.info('');
}

void day11Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day11Part1();
  day11Part2();
}
