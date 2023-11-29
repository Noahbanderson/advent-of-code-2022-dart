import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(9).readAsLinesSync();

final _logger = Logger('Day9');

///.........
///...%%%...
///..%###%..
///..%#T#%..
///..%###%..
///...%%%...
///.........

class Knot {
  int x;
  int y;

  Knot({this.x = 0, this.y = 0});

  (int, int) get pos => (x, y);
}

void day9Part1() {
  final head = Knot();
  final tail = Knot();

  final direction = {
    'U': (0, 1),
    'D': (0, -1),
    'L': (-1, 0),
    'R': (1, 0),
  };

  final tailTouched = <(int, int)>{}..add(tail.pos);

  for (final instruction in input) {
    final [dir, distStr] = instruction.split(' ');
    final dist = int.parse(distStr);

    for (var i = 0; i < dist; i++) {
      final (x, y) = direction[dir]!;
      head.x += x;
      head.y += y;

      final dx = head.x - tail.x;
      final dy = head.y - tail.y;

      if (dx.abs() < 2 && dy.abs() < 2) {
        // not far enough to elicit a change
        continue;
      }

      if (dx.isPositive) {
        tail.x++;
      } else if (dx.isNegative) {
        tail.x--;
      }

      if (dy.isPositive) {
        tail.y++;
      } else if (dy.isNegative) {
        tail.y--;
      }

      tailTouched.add(tail.pos);
    }
  }

  _logger.info("totalTailTouched: ${tailTouched.length}");
}

extension on int {
  bool get isPositive => !isNegative && !isZero;
  bool get isZero => this == 0;
}

void day9Part2() {
  // H, 1, 2, 3, 4, 5, 6, 7, 8, T // 10 knots total
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day9Part1();
  // day9Part2();
}
