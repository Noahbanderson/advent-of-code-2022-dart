import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(22).readAsLinesSync();

final _logger = Logger('Day22');

void day22Part1() {
  // TODO: Implement

  _logger.info('');
}

void day22Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day22Part1();
  day22Part2();
}
