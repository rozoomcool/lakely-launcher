class ServiceLocator {
  static final Map<Type, dynamic> _services = {};

  static void register<T>(T instance) {
    _services[T] = instance;
  }

  static T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T not found');
    }
    return service as T;
  }
}
