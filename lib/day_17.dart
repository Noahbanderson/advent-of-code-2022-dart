import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(17).readAsLinesSync();

final _logger = Logger('Day17');

void day17Part1() {
  // TODO: Implement

  _logger.info('');
}

void day17Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day17Part1();
  day17Part2();
}
