import 'package:logger/logger.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';

class GetAllBerita {
  final BeritaRepositories repo;
  const GetAllBerita(this.repo);

  Future<List<BeritaEntities>> execute(){
    Logger().d("usecase diajalankan");
    return repo.getAllBerita();
  }
}