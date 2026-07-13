dart
import 'package:uuid/uuid.dart';

class IdGenerator {
  static const _uuid = Uuid();

  static String generate() => _uuid.v4();

  static String generateWithPrefix(String prefix) => '${prefix}_${_uuid.v4()}';
}
