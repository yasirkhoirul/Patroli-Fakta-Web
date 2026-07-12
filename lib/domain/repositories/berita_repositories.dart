import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/entities/berita_type.dart';

abstract class BeritaRepositories {
  Future<List<BeritaEntities>> getAllBerita({required BeritaType type});
  Future<BeritaEntities> getDetailBerita(id);
  Future updateBerita(BeritaEntities data);
  Future removeBerita(id);
  Future uploadBerita(BeritaEntities data);
}
