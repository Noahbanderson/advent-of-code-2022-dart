import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(25).readAsLinesSync();

final _logger = Logger('Day25');

void day25Part1() {
  // TODO: Implement

  _logger.info('');
}

void day25Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day25Part1();
  day25Part2();
}
