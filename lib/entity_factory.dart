import 'package:flutter_app/model/line_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "LineModelEntity") {
      return LineModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}