import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(10).readAsLinesSync();

final _logger = Logger('Day10');

var isPart2 = false;

class Cpu {
  var cycleCounter = 0;
  var x = 1;

  final void Function(int cycle, int x) onEachCycle;

  Cpu({required this.onEachCycle});

  void cycle() {
    if (isPart2) {
      onEachCycle(cycleCounter, x);
      cycleCounter++;
    } else {
      onEachCycle(++cycleCounter, x);
    }
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
  isPart2 = true;
  final oneDimScreen = <String>[];

  final cpu = Cpu(onEachCycle: (final cycle, final x) {
    final spritePositions = [x - 1, x, x + 1];
    oneDimScreen.add(spritePositions.contains(cycle % 40) ? '#' : '.');
  });

  for (final instruction in input) {
    cpu.cycle();
    if (instruction != 'noop') {
      cpu.cycle();
      cpu.x += int.parse(instruction.split(' ').last);
    }
  }

  final display = [
    oneDimScreen.getRange(0, 39),
    oneDimScreen.getRange(40, 79),
    oneDimScreen.getRange(80, 119),
    oneDimScreen.getRange(120, 159),
    oneDimScreen.getRange(160, 199),
    oneDimScreen.getRange(200, 239),
  ].map((final row) => row.join('')).join('\n');

  print(display);
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day10Part1();
  day10Part2();
}
