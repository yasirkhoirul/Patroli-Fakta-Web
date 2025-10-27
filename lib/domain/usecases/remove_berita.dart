import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';

class RemoveBerita {
  final BeritaRepositories repo;
  RemoveBerita(this.repo);
  Future execute(String id) {
    return repo.removeBerita(id);
  }
}
