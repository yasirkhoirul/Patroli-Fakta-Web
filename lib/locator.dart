import 'package:get_it/get_it.dart';
import 'package:patroli_fakta/data/data_source/auth_remote_source.dart';
import 'package:patroli_fakta/data/data_source/data_berita_remote_source.dart';
import 'package:patroli_fakta/data/repositories/auth_repositories_impl.dart';
import 'package:patroli_fakta/data/repositories/berita_repositories_impl.dart';
import 'package:patroli_fakta/domain/repositories/auth_repositories.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';
import 'package:patroli_fakta/domain/usecases/get_all_berita.dart';
import 'package:patroli_fakta/domain/usecases/get_detail_berita.dart';
import 'package:patroli_fakta/domain/usecases/login_user.dart';
import 'package:patroli_fakta/domain/usecases/remove_berita.dart';
import 'package:patroli_fakta/domain/usecases/update_berita.dart';
import 'package:patroli_fakta/domain/usecases/upload_berita.dart';
import 'package:patroli_fakta/presentation/provider/berita_detail_notifier.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';
import 'package:patroli_fakta/presentation/provider/berita_upload_notifier.dart';
import 'package:patroli_fakta/presentation/provider/login_notifier.dart';
import 'package:patroli_fakta/presentation/provider/removeberita_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getit = GetIt.instance;

void init(){
  getit.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client,);

  //remote
  getit.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSourceimpl(getit.get<SupabaseClient>()),);
  getit.registerLazySingleton<DataBeritaRemoteSource>(() => DataBeritaRemoteSourceimpl(getit.get<SupabaseClient>()),);

  //repo
  getit.registerLazySingleton<BeritaRepositories>(() => BeritaRepositoriesImpl(getit.get<DataBeritaRemoteSource>()));
  getit.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImpl(getit.get<AuthRemoteSource>()),);

  //usecase
  getit.registerLazySingleton(() => LoginUser(getit.get<AuthRepositories>()),);
  getit.registerLazySingleton(() => GetAllBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => GetDetailBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => RemoveBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => UpdateBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => UploadBerita(getit.get<BeritaRepositories>()),);

  //notifier
  getit.registerFactory(() => LoginNotifier(getit.get<LoginUser>()),);
  getit.registerFactory(() => BeritaListNotifier(getallberita:getit.get<GetAllBerita>()),);
  getit.registerFactory(() => BeritaDetailNotifier(beritadata: getit.get<GetDetailBerita>(),),);
  getit.registerFactory(() => BeritaUploadNotifier(getit.get<UploadBerita>()),);
  getit.registerFactory(() => RemoveberitaNotifier(removeberita:getit.get<RemoveBerita>()),);
}