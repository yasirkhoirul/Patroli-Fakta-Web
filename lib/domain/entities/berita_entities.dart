import 'package:patroli_fakta/domain/entities/berita_type.dart';

class BeritaEntities {
  final int id;
  final String judul;
  final String deskripsi;
  final String createdAt;
  final BeritaType type;
  BeritaEntities(this.id, this.judul, this.deskripsi, this.createdAt, this.type);
}
