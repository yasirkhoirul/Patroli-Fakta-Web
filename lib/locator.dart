import 'package:get_it/get_it.dart';
import 'package:patroli_fakta/data/data_source/data_berita_remote_source.dart';
import 'package:patroli_fakta/data/repositories/berita_repositories_impl.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';
import 'package:patroli_fakta/domain/usecases/get_all_berita.dart';
import 'package:patroli_fakta/domain/usecases/get_detail_berita.dart';
import 'package:patroli_fakta/domain/usecases/remove_berita.dart';
import 'package:patroli_fakta/domain/usecases/update_berita.dart';
import 'package:patroli_fakta/domain/usecases/upload_berita.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getit = GetIt.instance;

void init(){
  getit.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client,);
  getit.registerLazySingleton<DataBeritaRemoteSource>(() => DataBeritaRemoteSourceimpl(getit.get<SupabaseClient>()),);
  getit.registerLazySingleton<BeritaRepositories>(() => BeritaRepositoriesImpl(getit.get<DataBeritaRemoteSource>()));
  getit.registerLazySingleton(() => GetAllBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => GetDetailBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => RemoveBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => UpdateBerita(getit.get<BeritaRepositories>()),);
  getit.registerLazySingleton(() => UploadBerita(getit.get<BeritaRepositories>()),);
  getit.registerFactory(() => BeritaListNotifier(getallberita:getit.get<GetAllBerita>()),);
}