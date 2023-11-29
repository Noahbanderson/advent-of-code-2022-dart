import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(20).readAsLinesSync();

final _logger = Logger('Day20');

void day20Part1() {
  // TODO: Implement

  _logger.info('');
}

void day20Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day20Part1();
  day20Part2();
}
