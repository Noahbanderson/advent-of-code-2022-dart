import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(12).readAsLinesSync();

final _logger = Logger('Day12');

void day12Part1() {
  // TODO: Implement

  _logger.info('');
}

void day12Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day12Part1();
  day12Part2();
}
