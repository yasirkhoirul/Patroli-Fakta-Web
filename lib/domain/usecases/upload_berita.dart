import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';

class UploadBerita {
  final BeritaRepositories repo;
  UploadBerita(this.repo);
  Future execute(BeritaEntities data){
    return repo.uploadBerita(data);
  }
}