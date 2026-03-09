/// 日志级别
enum LogLevel {
  /// 调试信息 - 详细的调试信息
  debug(0, 'DEBUG', '🔍'),

  /// 信息 - 一般信息
  info(1, 'INFO', 'ℹ️'),

  /// 警告 - 警告信息
  warning(2, 'WARNING', '⚠️'),

  /// 错误 - 错误信息
  error(3, 'ERROR', '❌'),

  /// 致命错误 - 严重错误
  fatal(4, 'FATAL', '💀');

  const LogLevel(this.value, this.name, this.emoji);

  final int value;
  final String name;
  final String emoji;

  /// 是否应该记录此级别的日志
  bool shouldLog(LogLevel minLevel) {
    return value >= minLevel.value;
  }

  @override
  String toString() => name;
}
