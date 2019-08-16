import 'package:flutter_app/model/lineinfo_entity.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "LineinfoEntity") {
      return LineinfoEntity.fromJson(json) as T;
    } else if (T.toString() == "LineModelEntity") {
      return LineModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}