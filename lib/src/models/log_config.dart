import 'log_level.dart';

/// 日志配置
class LogConfig {
  const LogConfig({
    this.minLevel = LogLevel.debug,
    this.enableConsole = true,
    this.enableFile = false,
    this.enableRemote = false,
    this.filePath,
    this.remoteUrl,
    this.maxFileSize = 10 * 1024 * 1024, // 10MB
    this.maxFileCount = 5,
    this.includeTimestamp = true,
    this.includeTag = true,
    this.includeEmoji = true,
    this.prettyPrint = true,
  });

  /// 最小日志级别
  final LogLevel minLevel;

  /// 是否启用控制台输出
  final bool enableConsole;

  /// 是否启用文件日志
  final bool enableFile;

  /// 是否启用远程日志
  final bool enableRemote;

  /// 文件日志路径
  final String? filePath;

  /// 远程日志URL
  final String? remoteUrl;

  /// 最大文件大小（字节）
  final int maxFileSize;

  /// 最大文件数量
  final int maxFileCount;

  /// 是否包含时间戳
  final bool includeTimestamp;

  /// 是否包含标签
  final bool includeTag;

  /// 是否包含emoji
  final bool includeEmoji;

  /// 是否美化输出
  final bool prettyPrint;

  /// 复制并修改配置
  LogConfig copyWith({
    LogLevel? minLevel,
    bool? enableConsole,
    bool? enableFile,
    bool? enableRemote,
    String? filePath,
    String? remoteUrl,
    int? maxFileSize,
    int? maxFileCount,
    bool? includeTimestamp,
    bool? includeTag,
    bool? includeEmoji,
    bool? prettyPrint,
  }) {
    return LogConfig(
      minLevel: minLevel ?? this.minLevel,
      enableConsole: enableConsole ?? this.enableConsole,
      enableFile: enableFile ?? this.enableFile,
      enableRemote: enableRemote ?? this.enableRemote,
      filePath: filePath ?? this.filePath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      maxFileCount: maxFileCount ?? this.maxFileCount,
      includeTimestamp: includeTimestamp ?? this.includeTimestamp,
      includeTag: includeTag ?? this.includeTag,
      includeEmoji: includeEmoji ?? this.includeEmoji,
      prettyPrint: prettyPrint ?? this.prettyPrint,
    );
  }
}
