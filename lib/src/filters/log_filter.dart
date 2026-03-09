import '../models/log_record.dart';
import '../models/log_level.dart';

/// 日志过滤器接口
abstract class LogFilter {
  bool shouldLog(LogRecord record);
}

/// 级别过滤器
class LevelFilter implements LogFilter {
  LevelFilter(this.minLevel);

  final LogLevel minLevel;

  @override
  bool shouldLog(LogRecord record) {
    return record.level.shouldLog(minLevel);
  }
}

/// 标签过滤器
class TagFilter implements LogFilter {
  TagFilter(this.allowedTags);

  final List<String> allowedTags;

  @override
  bool shouldLog(LogRecord record) {
    if (record.tag == null) return false;
    return allowedTags.contains(record.tag);
  }
}

/// 组合过滤器
class CompositeFilter implements LogFilter {
  CompositeFilter(this.filters, {this.requireAll = true});

  final List<LogFilter> filters;
  final bool requireAll;

  @override
  bool shouldLog(LogRecord record) {
    if (requireAll) {
      return filters.every((filter) => filter.shouldLog(record));
    } else {
      return filters.any((filter) => filter.shouldLog(record));
    }
  }
}
