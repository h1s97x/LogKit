import 'package:log_kit/log_kit.dart';

void main() async {
  // 初始化LogKit
  LogKit.init(
    minLevel: LogLevel.debug,
    enableConsole: true,
    enableFile: true,
    filePath: 'logs',
    enableRemote: false,
    includeEmoji: true,
  );

  // 基本日志
  LogKit.d('This is a debug message');
  LogKit.i('This is an info message');
  LogKit.w('This is a warning message');
  LogKit.e('This is an error message');

  // 带标签的日志
  LogKit.i('User logged in', tag: 'AUTH');
  LogKit.i('Data loaded', tag: 'DATA');

  // 带额外数据的日志
  LogKit.i(
    'API request completed',
    tag: 'API',
    data: {
      'url': 'https://api.example.com/users',
      'method': 'GET',
      'status': 200,
      'duration': 150,
    },
  );

  // 错误日志
  try {
    throw Exception('Something went wrong!');
  } catch (e, stack) {
    LogKit.e(
      'Failed to process data',
      tag: 'ERROR',
      error: e,
      stackTrace: stack,
    );
  }

  // 事件日志
  LogKit.event('user_login', data: {
    'userId': '12345',
    'timestamp': DateTime.now().toIso8601String(),
  });

  LogKit.event('button_clicked', data: {
    'buttonId': 'submit_button',
    'screen': 'home',
  });

  // 等待日志写入完成
  await Future.delayed(const Duration(seconds: 1));

  // 关闭LogKit
  await LogKit.close();

  // ignore: avoid_print
  print('\n✅ LogKit example completed!');
}
