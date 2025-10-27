import 'package:patroli_fakta/domain/entities/berita_entities.dart';

abstract class BeritaRepositories {
  Future<List<BeritaEntities>> getAllBerita();
  Future<BeritaEntities> getDetailBerita(id);
  Future updateBerita(BeritaEntities data);
  Future removeBerita(id);
  Future uploadBerita(BeritaEntities data);
}
