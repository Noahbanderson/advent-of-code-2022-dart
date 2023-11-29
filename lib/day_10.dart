import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(10).readAsLinesSync();

final _logger = Logger('Day10');

class Cpu {
  var cycleCounter = 0;
  var x = 1;

  final void Function(int cycle, int x) onEachCycle;

  Cpu({required this.onEachCycle});

  void cycle() {
    onEachCycle(++cycleCounter, x);
  }
}

void day10Part1() {
  var signalStrengthSum = 0;
  final cpu = Cpu(onEachCycle: (final cycle, final x) {
    if ([20, 60, 100, 140, 180, 220].contains(cycle)) {
      signalStrengthSum += cycle * x;
      _logger.fine('Major Cycle Hit! cycle: $cycle, x: $x -- total: ${cycle * x}');
    }
  });

  for (final instruction in input) {
    if (instruction == 'noop') {
      cpu.cycle();
      continue;
    }

    final v = int.parse(instruction.split(' ').last);

    cpu.cycle();

    cpu.cycle();

    cpu.x += v;
  }

  _logger.info('signalStrengthSum: $signalStrengthSum');
}

void day10Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day10Part1();
  day10Part2();
}
