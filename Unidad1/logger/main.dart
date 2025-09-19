class Logger {
  static final Map<String, Logger> _cache = {};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    }

    final logger = Logger._privado(name);
    _cache[name] = logger;
    return logger;
  }

  Logger._privado(this.name);

  final String name;

  void log(String message) => print('[$name] $message');
}

