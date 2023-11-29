import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(6).readAsLinesSync().first;

final _logger = Logger('Day6');

void day6Part1({final int packetLen = 4}) {
  final window = <String>[]; // Should only be 4 in length max
  var rval = -1;
  for (final info in input.split('').indexed) {
    final (index, char) = info;
    if (window.length < packetLen) {
      window.add(char);
      continue;
    }

    if (window.toSet().length == packetLen) {
      rval = index;
      break;
    }

    window.removeAt(0);
    window.add(char);
  }

  _logger.info('rval: $rval');
}

void day6Part2() => day6Part1(packetLen: 14);

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day6Part1();
  day6Part2();
}
