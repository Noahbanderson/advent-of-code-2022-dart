import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(5).readAsLinesSync();

final _logger = Logger('Day5');

/* Taken from the top of the input, this is the initial state of the stacks
        [M]     [B]             [N]
[T]     [H]     [V] [Q]         [H]
[Q]     [N]     [H] [W] [T]     [Q]
[V]     [P] [F] [Q] [P] [C]     [R]
[C]     [D] [T] [N] [N] [L] [S] [J]
[D] [V] [W] [R] [M] [G] [R] [N] [D]
[S] [F] [Q] [Q] [F] [F] [F] [Z] [S]
[N] [M] [F] [D] [R] [C] [W] [T] [M]
 1   2   3   4   5   6   7   8   9 
*/

// final stacks = [
//   ['T', 'Q', 'V', 'C', 'D', 'S', 'N'],
//   ['V', 'F', 'M'],
//   ['M', 'H', 'N', 'P', 'D', 'W', 'Q', 'F'],
//   ['F', 'T', 'R', 'Q', 'D'],
//   ['B', 'V', 'H', 'Q', 'N', 'M', 'F', 'R'],
//   ['Q', 'W', 'P', 'N', 'G', 'F', 'C'],
//   ['T', 'C', 'L', 'R', 'F', 'W'],
//   ['S', 'N', 'Z', 'T'],
//   ['N', 'H', 'Q', 'R', 'J', 'D', 'S', 'M'],
// ];

final stacks = [
  ['N', 'S', 'D', 'C', 'V', 'Q', 'T'],
  ['M', 'F', 'V'],
  ['F', 'Q', 'W', 'D', 'P', 'N', 'H', 'M'],
  ['D', 'Q', 'R', 'T', 'F'],
  ['R', 'F', 'M', 'N', 'Q', 'H', 'V', 'B'],
  ['C', 'F', 'G', 'N', 'P', 'W', 'Q'],
  ['W', 'F', 'R', 'L', 'C', 'T'],
  ['T', 'Z', 'N', 'S'],
  ['M', 'S', 'D', 'J', 'R', 'Q', 'H', 'N'],
];

final re = RegExp(r'^move (?<Quantity>\d+) from (?<From>\d) to (?<To>\d)$');

void day5Part1({final bool reverseStacked = false}) {
  final myStack = [
    for (final stack in stacks) [...stack]
  ];

  for (final instruction in input) {
    final match = re.firstMatch(instruction)!;

    final quantity = int.parse(match.namedGroup('Quantity')!);
    final from = int.parse(match.namedGroup('From')!) - 1;
    final to = int.parse(match.namedGroup('To')!) - 1;

    final taken = <String>[];
    for (var i = 0; i < quantity; i++) {
      final last = myStack[from].removeLast();
      taken.add(last);
    }

    myStack[to].addAll(reverseStacked ? taken.reversed : taken);
  }

  final tops = myStack.map((final stack) => stack.last).join('');

  _logger.info('The top of the crates: $tops');
}

void day5Part2() => day5Part1(reverseStacked: true);

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day5Part1();
  day5Part2();
}
