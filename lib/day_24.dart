import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(24).readAsLinesSync();

final _logger = Logger('Day24');

void day24Part1() {
  // TODO: Implement

  _logger.info('');
}

void day24Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day24Part1();
  day24Part2();
}
