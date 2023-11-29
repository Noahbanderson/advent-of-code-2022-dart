import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(21).readAsLinesSync();

final _logger = Logger('Day21');

void day21Part1() {
  // TODO: Implement

  _logger.info('');
}

void day21Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day21Part1();
  day21Part2();
}
