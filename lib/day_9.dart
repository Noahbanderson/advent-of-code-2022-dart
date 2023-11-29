import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(9).readAsLinesSync();

final _logger = Logger('Day9');

void day9Part1() {
  // TODO: Implement

  _logger.info('');
}

void day9Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day9Part1();
  day9Part2();
}
