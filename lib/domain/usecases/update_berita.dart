import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';

class UpdateBerita {
  final BeritaRepositories repo;
  UpdateBerita(this.repo);

  Future excute(BeritaEntities data) {
    return repo.updateBerita(data);
  }
}
