import 'log_level.dart';

/// 日志记录
class LogRecord {
  LogRecord({
    required this.level,
    required this.message,
    DateTime? timestamp,
    this.tag,
    this.error,
    this.stackTrace,
    this.data,
  }) : timestamp = timestamp ?? DateTime.now();

  /// 从JSON创建
  factory LogRecord.fromJson(Map<String, dynamic> json) {
    return LogRecord(
      level: LogLevel.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => LogLevel.info,
      ),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      tag: json['tag'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  /// 日志级别
  final LogLevel level;

  /// 日志消息
  final String message;

  /// 时间戳
  final DateTime timestamp;

  /// 日志标签
  final String? tag;

  /// 错误对象
  final Object? error;

  /// 堆栈跟踪
  final StackTrace? stackTrace;

  /// 额外数据
  final Map<String, dynamic>? data;

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'level': level.name,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      if (tag != null) 'tag': tag,
      if (error != null) 'error': error.toString(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
      if (data != null) 'data': data,
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write('[${level.name}]');
    if (tag != null) buffer.write(' [$tag]');
    buffer.write(' $message');
    if (error != null) buffer.write('\nError: $error');
    if (stackTrace != null) buffer.write('\n$stackTrace');
    return buffer.toString();
  }
}
