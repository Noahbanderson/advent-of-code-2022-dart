import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(10).readAsLinesSync();

final _logger = Logger('Day10');

void day10Part1() {
  // TODO: Implement

  _logger.info('');
}

void day10Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day10Part1();
  day10Part2();
}
