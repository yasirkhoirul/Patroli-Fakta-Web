import 'package:flutter/material.dart';
import 'package:patroli_fakta/domain/entities/user_entities.dart';
import 'package:patroli_fakta/domain/usecases/login_user.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';

class LoginNotifier extends ChangeNotifier{
  UserEntities? _user;
  UserEntities? get user => _user;
  StatusProvider status = StatusIsloading();
  LoginNotifier(this.usecaselogin);
  final LoginUser usecaselogin;
  login(String email, String password)async{
    status = StatusIsloading();
    notifyListeners();
    try {
    _user = await usecaselogin.execute(email, password);
      if(user!= null){
        status = Issuksesmessage(message: "Login Berhasil");
      }else{
        status = Iserror("gagal melakukan login");
      }
    } catch (e) {
      status = Iserror(e.toString());
    } finally{
      notifyListeners();
    }
  }

  setidle(){
    status = Isidle();
    notifyListeners();
  }
  
}