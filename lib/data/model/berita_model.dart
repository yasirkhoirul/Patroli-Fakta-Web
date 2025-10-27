import 'package:patroli_fakta/domain/entities/berita_entities.dart';

class BeritaModel {
  final int id;
  final String judul;
  final String deskripsi;
  final String createdAt;
  BeritaModel(
    this.id, {
    required this.judul,
    required this.deskripsi,
    required this.createdAt,
  });

  factory BeritaModel.fromjson(Map<String, dynamic> json) {
    return BeritaModel(
      json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      createdAt: json['createdAt'],
    );
  }

  factory BeritaModel.fromEntity(BeritaEntities data) {
    return BeritaModel(
      data.id,
      judul: data.judul,
      deskripsi: data.deskripsi,
      createdAt: data.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'judul': judul,
    'deskripsi': deskripsi,
    'createdAt': createdAt,
  };

  BeritaEntities toEntities() {
    return BeritaEntities(id, judul, deskripsi, createdAt);
  }
}
