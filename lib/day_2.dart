import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(2).readAsLinesSync();

final _logger = Logger('Day2');

void day2Part1() {
  // 'A' & 'X' = Rock
  // 'B' & 'Y' = Paper
  // 'C' & 'Z' = Scissors

  const rock = 1;
  const paper = 2;
  const scissors = 3;

  const lose = 0;
  const draw = 3;
  const win = 6;

  const guide = {
    'A X': rock + draw,
    'A Y': paper + win,
    'A Z': scissors + lose,
    //
    'B X': rock + lose,
    'B Y': paper + draw,
    'B Z': scissors + win,
    //
    'C X': rock + win,
    'C Y': paper + lose,
    'C Z': scissors + draw,
  };
  final result = input.fold(0, (final sum, final play) => guide[play]! + sum);
  _logger.info('Final Result: $result');
}

void day2Part2() {
  // 'A' = Rock
  // 'B' = Paper
  // 'C' = Scissors
  //
  // 'X' = Lose
  // 'Y' = Draw
  // 'Z' = Win

  const rock = 1;
  const paper = 2;
  const scissors = 3;

  const lose = 0;
  const draw = 3;
  const win = 6;

  const guide = {
    'A X': lose + scissors,
    'A Y': draw + rock,
    'A Z': win + paper,
    //
    'B X': lose + rock,
    'B Y': draw + paper,
    'B Z': win + scissors,
    //
    'C X': lose + paper,
    'C Y': draw + scissors,
    'C Z': win + rock,
  };

  final result = input.fold(0, (final sum, final play) => guide[play]! + sum);
  _logger.info('Final Result: $result');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day2Part1();
  day2Part2();
}
