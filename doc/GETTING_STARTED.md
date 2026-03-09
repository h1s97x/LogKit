# LogKit - 快速开始指南

欢迎使用 LogKit！这是一个功能完善的 Flutter 日志工具包。

## 安装

### 方式 1：本地依赖

```yaml
dependencies:
  log_kit:
    path: ../log_kit
```

### 方式 2：Git 依赖

```yaml
dependencies:
  log_kit:
    git:
      url: https://github.com/h1s97x/LogKit.git
      ref: main
```

然后运行：

```bash
flutter pub get
```

## 快速开始

### 1. 基础使用

```dart
import 'package:log_kit/log_kit.dart';

void main() {
  // 初始化 LogKit
  LogKit.init(
    minLevel: LogLevel.debug,
    enableConsole: true,
  );

  // 记录日志
  LogKit.d('Debug message');
  LogKit.i('Info message');
  LogKit.w('Warning message');
  LogKit.e('Error message');
  LogKit.f('Fatal error');

  // 关闭 LogKit
  LogKit.close();
}
```

### 2. 带标签的日志

```dart
LogKit.i('User logged in', tag: 'AUTH');
LogKit.i('Data loaded', tag: 'DATA');
LogKit.e('Network error', tag: 'NETWORK');
```

### 3. 带数据的日志

```dart
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
```

### 4. 错误日志

```dart
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
```

### 5. 事件追踪

```dart
LogKit.event('user_login', data: {
  'userId': '12345',
  'timestamp': DateTime.now().toIso8601String(),
});

LogKit.event('button_clicked', data: {
  'buttonId': 'submit_button',
  'screen': 'home',
});
```

## 配置选项

### 开发环境配置

```dart
LogKit.init(
  minLevel: LogLevel.debug,     // 记录所有日志
  enableConsole: true,          // 启用控制台输出
  enableFile: false,            // 关闭文件日志
  enableRemote: false,          // 关闭远程日志
  includeEmoji: true,           // 显示 emoji
  prettyPrint: true,            // 美化输出
);
```

### 生产环境配置

```dart
LogKit.init(
  minLevel: LogLevel.warning,   // 只记录警告及以上
  enableConsole: false,         // 关闭控制台输出
  enableFile: true,             // 启用文件日志
  enableRemote: true,           // 启用远程日志
  filePath: 'logs',             // 文件日志路径
  remoteUrl: 'https://log.example.com/api/logs',  // 远程日志 URL
  maxFileSize: 10 * 1024 * 1024,  // 最大文件大小 (10MB)
  maxFileCount: 5,              // 最大文件数量
);
```

### 完整配置示例

```dart
LogKit.init(
  minLevel: LogLevel.info,           // 最小日志级别
  enableConsole: true,                // 启用控制台输出
  enableFile: true,                   // 启用文件日志
  enableRemote: true,                 // 启用远程日志
  filePath: 'logs',                   // 文件日志路径
  remoteUrl: 'https://log.example.com/api/logs',  // 远程日志 URL
  maxFileSize: 10 * 1024 * 1024,     // 最大文件大小 (10MB)
  maxFileCount: 5,                    // 最大文件数量
  includeTimestamp: true,             // 包含时间戳
  includeTag: true,                   // 包含标签
  includeEmoji: true,                 // 包含 emoji
  prettyPrint: true,                  // 美化输出
);
```

## 日志级别

LogKit 支持 5 个日志级别：

| 级别 | 方法 | 用途 | Emoji |
|------|------|------|-------|
| Debug | `LogKit.d()` | 调试信息 | 🔍 |
| Info | `LogKit.i()` | 一般信息 | ℹ️ |
| Warning | `LogKit.w()` | 警告信息 | ⚠️ |
| Error | `LogKit.e()` | 错误信息 | ❌ |
| Fatal | `LogKit.f()` | 致命错误 | 💀 |

## 日志输出格式

### 控制台输出

```
[2026-03-09 10:30:45] 🔍 [DEBUG] [TAG] This is a debug message
[2026-03-09 10:30:46] ℹ️ [INFO] [TAG] This is an info message
[2026-03-09 10:30:47] ⚠️ [WARNING] [TAG] This is a warning message
[2026-03-09 10:30:48] ❌ [ERROR] [TAG] This is an error message
```

### 文件日志

日志文件保存在指定的 `filePath` 目录下：

```
logs/
├── log_1709913930000.txt
├── log_1709913940000.txt
└── log_1709913950000.txt
```

### 远程日志

批量上传到服务器，JSON 格式：

```json
{
  "logs": [
    {
      "level": "INFO",
      "message": "User logged in",
      "timestamp": "2026-03-09T10:30:45.000Z",
      "tag": "AUTH",
      "data": {
        "userId": "12345"
      }
    }
  ]
}
```

## 在 Flutter 应用中使用

### 1. 在 main.dart 中初始化

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:log_kit/log_kit.dart';

void main() {
  // 初始化日志
  LogKit.init(
    minLevel: kDebugMode ? LogLevel.debug : LogLevel.warning,
    enableConsole: kDebugMode,
    enableFile: true,
    enableRemote: !kDebugMode,
    filePath: 'logs',
    remoteUrl: 'https://log.example.com/api/logs',
  );

  // 捕获全局错误
  FlutterError.onError = (details) {
    LogKit.e(
      'Flutter error',
      tag: 'FLUTTER',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogKit Demo',
      home: HomePage(),
    );
  }
}
```

### 2. 在页面中使用

```dart
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    LogKit.event('page_view', data: {
      'page': 'HomePage',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void _handleButtonClick() {
    LogKit.event('button_clicked', data: {
      'buttonId': 'submit_button',
      'screen': 'home',
    });
    
    // 业务逻辑
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LogKit Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleButtonClick,
          child: Text('Click Me'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    LogKit.close();
    super.dispose();
  }
}
```

## 最佳实践

### 1. 使用标签分类

```dart
// 网络请求
LogKit.i('API request', tag: 'NETWORK');

// 数据库操作
LogKit.i('Database query', tag: 'DB');

// 用户行为
LogKit.i('User action', tag: 'USER');

// 认证相关
LogKit.i('Login attempt', tag: 'AUTH');
```

### 2. 记录关键信息

```dart
// 记录 API 请求
LogKit.i('API request', tag: 'API', data: {
  'url': url,
  'method': method,
  'status': statusCode,
  'duration': duration,
});

// 记录错误
try {
  await fetchData();
} catch (e, stack) {
  LogKit.e(
    'Failed to fetch data',
    tag: 'NETWORK',
    error: e,
    stackTrace: stack,
  );
}
```

### 3. 环境区分

```dart
import 'package:flutter/foundation.dart';

void initLogging() {
  if (kDebugMode) {
    // 开发环境：详细日志
    LogKit.init(
      minLevel: LogLevel.debug,
      enableConsole: true,
      enableFile: false,
      includeEmoji: true,
    );
  } else {
    // 生产环境：精简日志
    LogKit.init(
      minLevel: LogLevel.warning,
      enableConsole: false,
      enableFile: true,
      enableRemote: true,
      remoteUrl: 'https://log.example.com/api/logs',
    );
  }
}
```

## 常见问题

### Q: 如何查看文件日志？

A: 日志文件保存在指定的 `filePath` 目录下，文件名格式为 `log_<timestamp>.txt`。可以直接打开查看。

### Q: 远程日志上传失败怎么办？

A: 远程日志上传失败会静默处理，不会影响应用运行。可以检查：
- 网络连接是否正常
- 服务器 URL 是否正确
- 服务器是否正常运行

### Q: 如何自定义日志格式？

A: 可以实现 `LogFormatter` 接口创建自定义格式化器：

```dart
class MyFormatter implements LogFormatter {
  @override
  String format(LogRecord record, LogConfig config) {
    return '${record.level}: ${record.message}';
  }
}

final logger = Logger(
  config: config,
  formatter: MyFormatter(),
);
```

### Q: 日志文件会占用太多空间吗？

A: LogKit 会自动管理日志文件：
- 单个文件超过 `maxFileSize` 时自动轮转
- 保留最近的 `maxFileCount` 个文件
- 自动删除旧文件

## 下一步

- 查看 [完整文档](README.md)
- 查看 [使用指南](doc/USAGE_GUIDE.md)
- 查看 [示例代码](example/log_kit_example.dart)
- 访问 [GitHub 仓库](https://github.com/h1s97x/LogKit)

## 获取帮助

- [GitHub Issues](https://github.com/h1s97x/LogKit/issues)
- [GitHub Discussions](https://github.com/h1s97x/LogKit/discussions)

---

**项目地址**: https://github.com/h1s97x/LogKit  
**版本**: 1.0.0  
**许可证**: MIT
