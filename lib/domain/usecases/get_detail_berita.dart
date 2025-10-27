import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';

class GetDetailBerita {
  final BeritaRepositories repo;
  const GetDetailBerita(this.repo);
  Future<BeritaEntities> execute(String id) {
    return repo.getDetailBerita(id);
  }
}
