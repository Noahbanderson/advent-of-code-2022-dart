import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(15).readAsLinesSync();

final _logger = Logger('Day15');

void day15Part1() {
  // TODO: Implement

  _logger.info('');
}

void day15Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day15Part1();
  day15Part2();
}
