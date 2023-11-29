import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(13).readAsLinesSync();

final _logger = Logger('Day13');

void day13Part1() {
  // TODO: Implement

  _logger.info('');
}

void day13Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day13Part1();
  day13Part2();
}
