import 'package:patroli_fakta/data/data_source/auth_remote_source.dart';
import 'package:patroli_fakta/data/model/user_model.dart';
import 'package:patroli_fakta/domain/entities/user_entities.dart';
import 'package:patroli_fakta/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthRemoteSource authremotesource;
  AuthRepositoriesImpl(this.authremotesource);
  @override
  Future<UserEntities> login(String email, String password) async {
    try {
      final UserModel data = await authremotesource.loginadmin(email, password);
      return data.toEntities();
    } catch (e) {
      throw Exception(e);
    }
  }
}
