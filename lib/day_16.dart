import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(16).readAsLinesSync();

final _logger = Logger('Day16');

void day16Part1() {
  // TODO: Implement

  _logger.info('');
}

void day16Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day16Part1();
  day16Part2();
}
