import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(19).readAsLinesSync();

final _logger = Logger('Day19');

void day19Part1() {
  // TODO: Implement

  _logger.info('');
}

void day19Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day19Part1();
  day19Part2();
}
