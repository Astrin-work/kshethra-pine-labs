
import 'hive.dart';

class ObjectFactory {
  static final ObjectFactory instance = ObjectFactory.internal();

  factory ObjectFactory() {
    return instance;
  }

  ObjectFactory.internal();

  final AppHive appHive = AppHive();
}
