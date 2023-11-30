import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(11).readAsLinesSync();

final _logger = Logger('Day11');

enum MathOp { add, multiply }

class Monkey {
  final int number;

  final List<int> items;

  final MathOp op;
  final int operand;

  final int divisibleBy;
  final int monkeyTrue;
  final int monkeyFalse;

  int inspected;

  Monkey({
    required this.number,
    required this.items,
    required this.op,
    required this.operand,
    required this.divisibleBy,
    required this.monkeyTrue,
    required this.monkeyFalse,
  }) : inspected = 0;

  factory Monkey.from(final List<String> details) {
    late final int number;
    late final List<int> items;
    late final MathOp op;
    late final int operand;
    late final int divisibleBy;
    late final int monkeyTrue;
    late final int monkeyFalse;

    for (var i = 0; i < details.length; i++) {
      final line = details[i];
      switch (i) {
        case 0: // monkey number
          number = int.parse(line.split(' ').last[0]);
          break;
        case 1: // starting items
          items = line.split(': ').last.split(', ').map(int.parse).toList();
          break;
        case 2: // operation: math op and operand
          op = line.contains('*') ? MathOp.multiply : MathOp.add;
          final operandStr = line.split(' ').last;
          operand = operandStr == 'old' ? -1 : int.parse(operandStr);
          break;
        case 3: // divisible by test
          divisibleBy = int.parse(line.split(' ').last);
          break;
        case 4: // test is true: monkey number
          monkeyTrue = int.parse(line.split(' ').last);
          break;
        case 5: // test is false: monkey number
          monkeyFalse = int.parse(line.split(' ').last);
          break;
        default:
      }
    }

    return Monkey(
      number: number,
      items: items,
      op: op,
      operand: operand,
      divisibleBy: divisibleBy,
      monkeyTrue: monkeyTrue,
      monkeyFalse: monkeyFalse,
    );
  }

  void takeTurn(final List<Monkey> monkeyPen) {
    for (final item in items) {
      inspected++;

      final theOperand = (operand == -1 ? item : operand);
      final newWorryLevel = switch (op) {
            MathOp.add => item + theOperand,
            MathOp.multiply => item * theOperand,
          } ~/
          3;

      final nextMonkey = newWorryLevel % divisibleBy == 0 ? monkeyTrue : monkeyFalse;

      monkeyPen[nextMonkey].items.add(newWorryLevel);
    }
    items.clear();
  }
}

void day11Part1() {
  // TODO: Implement

  final monkeyPen = <Monkey>[];

  // Parse Input
  var details = <String>[];
  for (final line in input) {
    if (line.isEmpty || line == input.last) {
      if (line == input.last) {
        details.add(line);
      }
      monkeyPen.add(Monkey.from(details));
      details = [];
    } else {
      details.add(line);
    }
  }

  _logger.fine('Monkeys Instantiated');

  // Perform 20 Rounds
  for (var i = 0; i < 20; i++) {
    _logger.fine('Commence Round $i');
    for (final monkey in monkeyPen) {
      monkey.takeTurn(monkeyPen);
    }
    // _logger.fine('Finish Round $i');
  }

  // Calculate the top two most active monkeys
  var most = 0;
  var secondMost = 0;
  for (final monkey in monkeyPen) {
    if (most < monkey.inspected) {
      secondMost = most;
      most = monkey.inspected;
    } else if (secondMost < monkey.inspected) {
      secondMost = monkey.inspected;
    }
  }

  final monkeyBusiness = most * secondMost;

  _logger.info('monkeyBusiness: $monkeyBusiness');
}

void day11Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day11Part1();
  day11Part2();
}
