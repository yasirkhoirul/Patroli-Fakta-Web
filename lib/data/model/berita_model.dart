import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/entities/berita_type.dart';

class BeritaModel {
  final int id;
  final String judul;
  final String deskripsi;
  final String createdAt;
  final BeritaType type;
  BeritaModel(
    this.id, {
    required this.judul,
    required this.deskripsi,
    required this.createdAt,
    required this.type,
  });

  factory BeritaModel.fromjson(Map<String, dynamic> json) {
    return BeritaModel(
      json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      createdAt: json['createdAt'],
      type: json['type'] == 'verified' ? BeritaType.verified : BeritaType.unverified,
    );
  }

  factory BeritaModel.fromEntity(BeritaEntities data) {
    return BeritaModel(
      data.id,
      judul: data.judul,
      deskripsi: data.deskripsi,
      createdAt: data.createdAt,
      type: data.type,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'judul': judul,
    'deskripsi': deskripsi,
    'createdAt': createdAt,
    'type': type == BeritaType.verified ? 'verified' : 'unverified',
  };

  BeritaEntities toEntities() {
    return BeritaEntities(id, judul, deskripsi, createdAt, type);
  }
}

