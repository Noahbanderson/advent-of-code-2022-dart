import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input =
    getDayInput(12).readAsLinesSync().map((final line) => line.split('')).toList();

final _logger = Logger('Day12');

var isPart2 = false;

class Node {
  final String char;

  final int height; // => corresponds to char

  final (int, int) idxPair; // Unique

  final List<Node> neighbors;

  final List<(int, int)> possibleNeighbors;

  Node({
    required this.char,
    required this.height,
    required this.idxPair,
    required this.neighbors,
    required this.possibleNeighbors,
  });

  @override
  String toString() => 'Node<$char>(id: $idxPair, h: $height)';
}

void day12Part1() {
  final maxRowIdx = input.length - 1;
  final maxColIdx = input.first.length - 1;

  late final Node start;
  late final Node end;

  // Map each char to a Node
  final List<List<Node>> nodeMatrix =
      input.indexed.fold(<List<Node>>[], (final outer, final rowData) {
    final (rowIdx, row) = rowData;

    final rval = row.indexed.fold(<Node>[], (final inner, final colData) {
      final (colIdx, char) = colData;

      final height = pointCharToInt(char);

      final possibleNeighbors = <(int, int)>[];

      // above
      final aboveRowIdx = rowIdx - 1;
      if (0 <= aboveRowIdx) {
        final pair = (aboveRowIdx, colIdx);
        final neighborHeight = pointCharToInt(input.atPair(pair));
        if (neighborHeight <= height + 1) {
          possibleNeighbors.add(pair);
        }
      }

      // below
      final belowRowIdx = rowIdx + 1;
      if (rowIdx + 1 <= maxRowIdx) {
        final pair = (belowRowIdx, colIdx);
        final neighborHeight = pointCharToInt(input.atPair(pair));
        if (neighborHeight <= height + 1) {
          possibleNeighbors.add(pair);
        }
      }

      //  left
      final leftColIdx = colIdx - 1;
      if (0 <= leftColIdx) {
        final pair = (rowIdx, leftColIdx);
        final neighborHeight = pointCharToInt(input.atPair(pair));
        if (neighborHeight <= height + 1) {
          possibleNeighbors.add(pair);
        }
      }

      //  right
      final rightColIdx = colIdx + 1;
      if (rightColIdx <= maxColIdx) {
        final pair = (rowIdx, rightColIdx);
        final neighborHeight = pointCharToInt(input.atPair(pair));
        if (neighborHeight <= height + 1) {
          possibleNeighbors.add(pair);
        }
      }

      final node = Node(
        char: char,
        height: height,
        idxPair: (rowIdx, colIdx),
        neighbors: [],
        possibleNeighbors: possibleNeighbors,
      );

      if (char == 'S') {
        start = node;
      } else if (char == 'E') {
        end = node;
      }

      return inner..add(node);
    });

    return outer..add(rval);
  });

  // Associate each node with it's neighbors
  nodeMatrix.forEach((final row) {
    for (final node in row) {
      final neighborNodes =
          node.possibleNeighbors.map((final pair) => nodeMatrix[pair.$1][pair.$2]);
      node.neighbors.addAll(neighborNodes);
    }
  });

  // part 2
  final startingPoints = isPart2
      ? nodeMatrix.fold(<Node>[], (final rval, final row) {
          return [
            ...rval,
            for (final node in row)
              if (node.height == 1) //
                node,
          ];
        })
      : [start];

  int? shortestTrip;

  for (final startingPoint in startingPoints) {
    final queue = [startingPoint];
    final visited = {startingPoint};
    final lineageMap = {
      startingPoint: [startingPoint],
    };

    while (queue.isNotEmpty) {
      final top = queue.removeAt(0);
      final toAdd = <Node>[];
      for (final neighbor in top.neighbors) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          lineageMap[neighbor] = [...lineageMap[top]!, neighbor];
          toAdd.add(neighbor);
        }
      }

      if (toAdd.contains(end)) {
        break;
      }

      queue.addAll(toAdd);
    }

    if (queue.isEmpty) {
      continue;
    }

    final tripLength = lineageMap[end]!.length - 1;

    if (shortestTrip == null || tripLength < shortestTrip) {
      shortestTrip = tripLength;
    }
  }

  _logger.info('Shorted Trip: $shortestTrip');
}

extension on List<List<String>> {
  String atPair(final (int, int) pair) => this[pair.$1][pair.$2];
}

int pointCharToInt(final String char) {
  if (char == 'S') {
    return 1;
  } else if (char == 'E') {
    return 26;
  } else {
    return char.codeUnits.first - 96;
  }
}

void day12Part2() {
  isPart2 = true;
  day12Part1();
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day12Part1();
  day12Part2();
}
