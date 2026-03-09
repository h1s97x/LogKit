import 'dart:async';
import '../models/log_record.dart';

/// 日志写入器接口
abstract class LogWriter {
  Future<void> write(LogRecord record, String formatted);
  Future<void> close();
}

/// 控制台写入器
class ConsoleWriter implements LogWriter {
  @override
  Future<void> write(LogRecord record, String formatted) async {
    // ignore: avoid_print
    print(formatted);
  }

  @override
  Future<void> close() async {
    // 控制台不需要关闭
  }
}
