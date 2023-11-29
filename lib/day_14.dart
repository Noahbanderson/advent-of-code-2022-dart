import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(14).readAsLinesSync();

final _logger = Logger('Day14');

void day14Part1() {
  // TODO: Implement

  _logger.info('');
}

void day14Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day14Part1();
  day14Part2();
}
