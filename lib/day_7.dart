import 'package:logging/logging.dart';

import 'logging.dart';
import 'utils.dart';

final input = getDayInput(7).readAsLinesSync();

final _logger = Logger('Day7');

final dirRe = RegExp(r'^\$ cd (?<Dir>\w+)$');

void day7Part1() {
  final root = Directory.empty(name: '/');
  var current = root;

  for (final line in input) {
    if (line.startsWith(r'$ cd')) {
      if (line.endsWith('/')) {
        current = root;
        continue;
      }

      if (line.endsWith('..')) {
        current = current.parent!;
        continue;
      }

      final dir = dirRe.firstMatch(line)!.namedGroup('Dir')!;

      current = current.entries[dir] as Directory;
      continue;
    }

    if (line == r'$ ls') {
      // ignore this line
      continue;
    }

    // Getting information about current dir entries
    final [size, entryName] = line.split(' ');
    if (line.startsWith('dir')) {
      current.entries[entryName] = Directory.empty(name: entryName, parent: current);
    } else {
      current.entries[entryName] = File(name: entryName, size: int.parse(size));
    }
  }

  final totalSize = root.calculateSize();

  var contrivedTotal = 0;
  root.forEachDir((final dir) {
    if (dir.size <= 100000) {
      contrivedTotal += dir.size;
    }
  });

  _logger.info('contrivedTotal: $contrivedTotal');
  _logger.info('totalSize: $totalSize');

  // -- Part 2 - \\

  final amountFree = 70000000 - totalSize;
  final amountNeeded = 30000000 - amountFree;

  _logger.info('amountFree: $amountFree');
  _logger.info('amountNeeded: $amountNeeded');

  Directory? current2;
  // I don't need to do a depth first check, really
  // If the current dir is too small, then the children
  // dirs will also be too small and we can skip them.
  root.forEachDir((final dir) {
    if (amountNeeded <= dir.size && dir.size < (current2?.size ?? totalSize)) {
      current2 = dir;
    }
  });

  _logger.info('current2.size: ${current2!.size}');
}

void day7Part2() {
  // TODO: Implement

  _logger.info('');
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(prettyPrint);

  day7Part1();
  // day7Part2();
}

final class Directory extends FileSystemEntry {
  final entries = <String, FileSystemEntry>{};

  final Directory? parent;

  Directory({required super.name, required super.size, this.parent});

  Directory.empty({required super.name, this.parent}) : super(size: 0);

  int calculateSize() {
    final size = [
      for (final entry in entries.values)
        switch (entry) {
          final Directory dir => dir.calculateSize(),
          File(:final size) => size,
        }
    ].reduce((final sum, final value) => sum + value);
    return this.size = size;
  }

  void forEachDir(final void Function(Directory dir) performAction) {
    performAction(this);
    for (final dir in entries.values.whereType<Directory>()) {
      dir.forEachDir(performAction);
    }
  }
}

final class File extends FileSystemEntry {
  File({required super.name, required super.size});
}

sealed class FileSystemEntry {
  final String name;
  int size;

  FileSystemEntry({required this.name, required this.size});
}
