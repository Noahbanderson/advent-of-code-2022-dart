import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(23).readAsLinesSync();

final _logger = Logger('Day23');

void day23Part1() {
  // TODO: Implement

  _logger.info('');
}

void day23Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day23Part1();
  day23Part2();
}
