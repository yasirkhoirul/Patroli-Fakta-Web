import 'package:patroli_fakta/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteSource {
  Future<UserModel> loginadmin(String email,String password);
}

class AuthRemoteSourceimpl implements AuthRemoteSource {
  final SupabaseClient supabase;
  AuthRemoteSourceimpl(this.supabase);
  @override
  Future<UserModel> loginadmin(String email,String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        return UserModel(res.user!.email!, res.session.toString());
      } else {
        throw Exception("terjadi kesalahan");
      }
    }on AuthApiException 
    catch (e) {
      throw Exception(e.message);
    }
  }
}
