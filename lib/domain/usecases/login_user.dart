import 'package:patroli_fakta/domain/entities/user_entities.dart';
import 'package:patroli_fakta/domain/repositories/auth_repositories.dart';

class LoginUser {
  final AuthRepositories auth;
  LoginUser(this.auth);
  Future<UserEntities> execute(String email,String password){
    return auth.login(email, password);
  }
}