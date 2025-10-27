import 'package:patroli_fakta/domain/entities/user_entities.dart';

class UserModel {
  final String email;
  final String session;
  UserModel(this.email, this.session);

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(json['email'], json['session']);
  }

  factory UserModel.fromEntity(UserEntities data) {
    return UserModel(data.email, data.session);
  }

  toEntities() {
    return UserEntities(email, session);
  }
}
