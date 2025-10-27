import 'package:patroli_fakta/domain/entities/user_entities.dart';

abstract class AuthRepositories {
  Future<UserEntities> login(String email,String password);
}