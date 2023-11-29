import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(9).readAsLinesSync();

final _logger = Logger('Day9');

class Node {
  bool occupiedByHead = false;

  bool _occupiedByTail = false;
  bool get occupiedByTail => _occupiedByTail;
  set occupiedByTail(final bool val) {
    if (val) {
      _wasVisitedByTail = true;
    }
    _occupiedByTail = val;
  }

  bool _wasVisitedByTail = false;
  bool get wasVisitedByTail => _wasVisitedByTail;

  // bool startingNode = false;

  Node({this.occupiedByHead = false, final bool occupiedByTail = false}) {
    this.occupiedByTail = occupiedByTail;
  }
}

void day9Part1() {
  final matrix = [
    [Node(occupiedByHead: true, occupiedByTail: true)]
  ];

  var currentHead = matrix[0][0];
  var headColIdx = 0;
  var headRowIdx = 0;

  var currentTail = matrix[0][0];
  var tailColIdx = 0;
  var tailRowIdx = 0;

  final re = RegExp(r'^(?<Dir>[RLUD]) (?<Dist>\d{1,2})$');
  for (final instruction in input) {
    final match = re.firstMatch(instruction);
    final dir = match!.namedGroup('Dir')!;
    final dist = int.parse(match.namedGroup('Dist')!);

    // U and D are row movements

    // R and L are column movements

    // Iterate [dist] number of times
    for (var i = 0; i < dist; i++) {
      // Moving the head
      if (dir == 'R') {
        // Adjust the matrix to fit the movement dir and dist
        final maxIndex = matrix[headRowIdx].length - 1;
        final nextHeadIndex = headColIdx + 1;
        if (maxIndex < nextHeadIndex) {
          // add a column to the right on the matrix
          for (final row in matrix) {
            row.add(Node());
          }
        }

        final nextHead = matrix[headRowIdx][nextHeadIndex];
        currentHead.occupiedByHead = false;
        nextHead.occupiedByHead = true;

        currentHead = nextHead;
        headColIdx = nextHeadIndex;
      } else if (dir == 'L') {
        // Adjust the matrix to fit the movement dir and dist

        var nextHeadIndex = headColIdx - 1;
        if (nextHeadIndex < 0) {
          // add a column to the left on the matrix
          for (final row in matrix) {
            row.insert(0, Node());
          }

          nextHeadIndex = 0; // This keeps us safe from negatives!
          tailColIdx++;
        }

        final nextHead = matrix[headRowIdx][nextHeadIndex];
        currentHead.occupiedByHead = false;
        nextHead.occupiedByHead = true;

        currentHead = nextHead;
        headColIdx = nextHeadIndex;
      } else if (dir == 'U') {
        // Adjust the matrix to fit the movement dir and dist
        var nextHeadIndex = headRowIdx - 1;
        if (nextHeadIndex < 0) {
          // add a row to the top on the matrix
          final colLen = matrix[0].length;
          matrix.insert(0, List.generate(colLen, (final _) => Node()));

          nextHeadIndex = 0; // This keeps us safe from negatives!
          tailRowIdx++;
          // We adjust the grid, we need to adjust the points
        }

        final nextHead = matrix[nextHeadIndex][headColIdx];
        currentHead.occupiedByHead = false;
        nextHead.occupiedByHead = true;

        currentHead = nextHead;
        headRowIdx = nextHeadIndex;
      } else if (dir == 'D') {
        // Adjust the matrix to fit the movement dir and dist
        final maxIndex = matrix.length - 1;
        final nextHeadIndex = headRowIdx + 1;
        if (maxIndex < nextHeadIndex) {
          // add 1 rows to the bottom on the matrix
          final colLen = matrix[0].length;
          matrix.add(List.generate(colLen, (final _) => Node()));
        }

        final nextHead = matrix[nextHeadIndex][headColIdx];
        currentHead.occupiedByHead = false;
        nextHead.occupiedByHead = true;

        currentHead = nextHead;
        headRowIdx = nextHeadIndex;
      }

      // Moving the tail

      // Check if the tail should move at all
      ///.........
      ///...%%%...
      ///..%###%..
      ///..%#T#%..
      ///..%###%..
      ///...%%%...
      ///.........
      ///
      /// # and T are unconsequential head spots
      /// % is where we need to calculate

      final nineClosest = [
        [tailRowIdx - 1, tailColIdx - 1],
        [tailRowIdx - 1, tailColIdx],
        [tailRowIdx - 1, tailColIdx + 1],
        [tailRowIdx, tailColIdx - 1],
        [tailRowIdx, tailColIdx],
        [tailRowIdx, tailColIdx + 1],
        [tailRowIdx + 1, tailColIdx - 1],
        [tailRowIdx + 1, tailColIdx],
        [tailRowIdx + 1, tailColIdx + 1],
      ];

      var headIsNear = false;
      for (final pair in nineClosest) {
        final [rowIdx, colIdx] = pair;

        if (rowIdx < 0 ||
            matrix.length - 1 < rowIdx ||
            colIdx < 0 ||
            matrix[0].length - 1 < colIdx) {
          // Out of bounds
          continue;
        }

        if (matrix[rowIdx][colIdx].occupiedByHead) {
          headIsNear = true;
          break;
        }
      }

      if (headIsNear) {
        // no-op! Head moved to an unconsequential node
        continue;
      }

      // If so, where to?
      // Move the tail!

      final headIsRight = tailColIdx < headColIdx;
      final headIsLeft = headColIdx < tailColIdx;
      final headIsAbove = headRowIdx < tailRowIdx;
      final headIsBelow = tailRowIdx < headRowIdx;

      // If head is along the main axes
      if (tailRowIdx == headRowIdx) {
        // on the horizontal axis
        if (headIsRight) {
          // to the right of the tail
          tailColIdx++;
        } else {
          // to the left of the tail
          tailColIdx--;
        }
      } else if (tailColIdx == headColIdx) {
        // on the vertical axis
        if (headIsBelow) {
          // to the bottom of the tail
          tailRowIdx++;
        } else {
          // to the top of the tail
          tailRowIdx--;
        }
      } else

      // move diagonally
      if (headIsRight && headIsBelow) {
        // move bottom and right one; + and +
        tailColIdx++;
        tailRowIdx++;
      } else if (headIsLeft && headIsAbove) {
        // move up and left one; - and -
        tailColIdx--;
        tailRowIdx--;
      } else if (headIsRight && headIsAbove) {
        // move up and right one
        tailColIdx++;
        tailRowIdx--;
      } else if (headIsLeft && headIsBelow) {
        // move bottom and left one
        tailColIdx--;
        tailRowIdx++;
      }

      currentTail.occupiedByTail = false;
      final nextTail = matrix[tailRowIdx][tailColIdx];
      nextTail.occupiedByTail = true;
      currentTail = nextTail;
    }
  }

  final tailVisited = matrix.fold(
    0,
    (final sum, final row) =>
        sum +
        row.fold(
          0,
          (final rowSum, final node) => rowSum + (node.wasVisitedByTail ? 1 : 0),
        ),
  );

  _logger.info('tailVisited: $tailVisited');
}

extension on List<List<Node>> {
  String get debug => map(
        (final line) => line.map(
          (final node) {
            return switch (0) {
              _ when node.occupiedByHead && node.occupiedByTail => 'B',
              _ when node.occupiedByHead => 'H',
              _ when node.occupiedByTail => 'T',
              _ => '.',
            };
          },
        ).join(''),
      ).join('\n');
}

void day9Part2() {
  // TODO: Implement

  // _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day9Part1();
  // day9Part2();
}
