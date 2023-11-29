import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(8).readAsLinesSync();

final _logger = Logger('Day8');

void day8Part1() {
  // TODO: Implement

  _logger.info('');
}

void day8Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day8Part1();
  day8Part2();
}
