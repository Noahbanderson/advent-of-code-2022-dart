import 'package:colorize/colorize.dart';
import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(8)
    .readAsLinesSync()
    .map((final line) => line
        .split('')
        .map((final treeHeight) => Tree(height: int.parse(treeHeight)))
        .toList())
    .toList();

final _logger = Logger('Day8');

class Tree {
  bool visible;
  final int height;
  int score; // Part 2

  Tree({required this.height, this.visible = false, this.score = -1});

  Tree.empty()
      : height = 0,
        visible = false,
        score = -1;

  @override
  String toString() => height.toString();
}

void day8Part1() {
  // Traverse rows, forward and back.
  markRows(input);

  // print(input.debug);

  // Traverse columns, up and down.
  final transposition = transposeMatrix(input);

  markRows(transposition);

  // print(transposeMatrix(transposition).debug);

  final totalVisible = transposition.fold(
    0,
    (final sum, final line) =>
        sum +
        line.fold(
          0,
          (final lineSum, final tree) => lineSum + (tree.visible ? 1 : 0),
        ),
  );

  _logger.info('totalVisible: $totalVisible');
}

void markRows(final List<List<Tree>> matrix) {
  for (final line in matrix) {
    var tallestTree = -1;
    for (final tree in line) {
      if (tallestTree < tree.height) {
        tree.visible = true;
        tallestTree = tree.height;
      }
    }

    tallestTree = -1;
    for (final tree in line.reversed) {
      if (tallestTree < tree.height) {
        tree.visible = true;
        tallestTree = tree.height;
      }
    }
  }
}

List<List<Tree>> transposeMatrix(final List<List<Tree>> matrix) {
  final rows = matrix.length;
  final columns = matrix[0].length;

  final result = List.generate(
    columns,
    (final index) => List<Tree>.filled(
      rows,
      Tree.empty(),
      growable: false,
    ),
  );

  for (var i = 0; i < rows; i++) {
    for (var j = 0; j < columns; j++) {
      result[j][i] = matrix[i][j];
    }
  }

  return result;
}

extension on List<List<Tree>> {
  String get debug => map(
        (final line) => line.map(
          (final tree) {
            final r = tree.height.toString();
            return tree.visible ? Colorize(r).red() : r;
          },
        ).join(''),
      ).join('\n');
}

void day8Part2() {
  var highestScore = 0;
  for (final lineEntry in input.indexed) {
    final (rowIndex, line) = lineEntry;
    for (final treeEntry in line.indexed) {
      final (columnIndex, tree) = treeEntry;

      final score = calculateTreeScore(tree, rowIndex, columnIndex);
      if (highestScore < score) {
        highestScore = score;
      }
    }
  }

  _logger.info('highestScore: $highestScore');
}

int calculateTreeScore(final Tree tree, final int rowIndex, final int columnIndex) {
  final rowsLength = input.length;
  final columnsLength = input[0].length;

  // Left search
  var leftCount = 0;
  for (var i = columnIndex - 1; 0 <= i; i--) {
    final qTree = input[rowIndex][i];

    leftCount++;
    if (tree.height <= qTree.height) {
      break;
    }
  }

  // Right search
  var rightCount = 0;
  for (var i = columnIndex + 1; i <= columnsLength - 1; i++) {
    final qTree = input[rowIndex][i];

    rightCount++;
    if (tree.height <= qTree.height) {
      break;
    }
  }

  // Up search
  var upCount = 0;
  for (var i = rowIndex - 1; 0 <= i; i--) {
    final qTree = input[i][columnIndex];

    upCount++;
    if (tree.height <= qTree.height) {
      break;
    }
  }

  // Down search
  var downCount = 0;
  for (var i = rowIndex + 1; i <= rowsLength - 1; i++) {
    final qTree = input[i][columnIndex];

    downCount++;
    if (tree.height <= qTree.height) {
      break;
    }
  }

  return tree.score = leftCount * rightCount * upCount * downCount;
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  // day8Part1();
  // day8Part2();
}
