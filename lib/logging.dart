import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

void prettyPrint(final LogRecord rec) {
  stdout.writeln(_formatLog(
    _makeLevelPart(rec.level),
    Colorize(_formatTime()).darkGray(),
    Colorize(rec.loggerName).lightGreen(),
    Colorize(rec.message).lightBlue(),
  ));
}

/* Private */

///
String _formatLog(final Object p1, final Object p2, final Object p3, final Object p4,
        [final bool newLine = false]) =>
    '[$p1] | $p2 | $p3: $p4${newLine ? '\n' : ''}';

String _formatTime() {
  final now = DateTime.now().toLocal();
  return "${DateFormat("a hh:mm:ss").format(now)} ${now.microsecond.toString().padRight(3, '0')}";
}

Colorize _makeLevelPart(final Level level) {
  return switch (level) {
    Level.SHOUT => Colorize(level.name).white().bgRed(),
    Level.SEVERE => Colorize(level.name).red(),
    Level.WARNING => Colorize(level.name).yellow(),
    Level.INFO => Colorize(level.name).blue(),
    Level.CONFIG => Colorize(level.name).lightBlue(),
    Level.FINE => Colorize(level.name).lightBlue(),
    Level.FINER => Colorize(level.name).lightBlue(),
    Level.FINEST => Colorize(level.name).lightBlue(),
    _ => Colorize(level.name).white(), // Level.ALL
  };
}
