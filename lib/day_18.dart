import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(18).readAsLinesSync();

final _logger = Logger('Day18');

void day18Part1() {
  // TODO: Implement

  _logger.info('');
}

void day18Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day18Part1();
  day18Part2();
}
