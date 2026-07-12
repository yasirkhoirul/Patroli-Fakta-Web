import 'package:logger/logger.dart';
import 'package:patroli_fakta/data/model/berita_model.dart';
import 'package:patroli_fakta/domain/entities/berita_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DataBeritaRemoteSource {
  Future<List<BeritaModel>> getListBerita({required BeritaType type});
  Future<BeritaModel> getDetailBerita(String id);
  Future update(BeritaModel data);
  Future removeBerita(String id);
  Future uploadBerita(BeritaModel data);
}

class DataBeritaRemoteSourceimpl extends DataBeritaRemoteSource {
  final SupabaseClient supabase;
  DataBeritaRemoteSourceimpl(this.supabase);
  @override
  Future<BeritaModel> getDetailBerita(String id) async {
    try {
      final data = await supabase.from("Berita").select().eq("id", id).single();
      return BeritaModel.fromjson(data);
    } catch (e) {
      throw Exception("gagal mengambil berita di remote source $e");
    }
  }

  @override
  Future<List<BeritaModel>> getListBerita({required BeritaType type}) async {
    try {
      if (type == BeritaType.verified) {
        final data = await supabase
            .from('Berita')
            .select()
            .eq('type', 'verified')
            .order('createdAt', ascending: false);
        return data.map((e) => BeritaModel.fromjson(e)).toList();
      } else if (type == BeritaType.unverified) {
        final data = await supabase
            .from('Berita')
            .select()
            .or('type.eq.unverified,type.is.null')
            .order('createdAt', ascending: false);
        return data.map((e) => BeritaModel.fromjson(e)).toList();
      } else {
        final data = await supabase
            .from('Berita')
            .select()
            .order('createdAt', ascending: false);
        return data.map((e) => BeritaModel.fromjson(e)).toList();
      }
    } catch (e) {
      throw Exception("gagal mengambil berita di remote source $e");
    }
  }

  @override
  Future uploadBerita(BeritaModel data) async {
    Logger().d("masuk source ${data.judul}");

    try {
      final datatoinsert = data.toJson();
      datatoinsert.remove('id');
      datatoinsert.remove('createdAt');
      await supabase.from('Berita').insert(datatoinsert);
    } catch (e) {
      throw Exception("gagal mengambil berita di remote source $e");
    }
  }

  @override
  Future removeBerita(String id) async {
    try {
      await supabase.from('Berita').delete().eq('id', id);
    } catch (e) {
      throw Exception("gagal mengambil berita di remote source $e");
    }
  }

  @override
  Future update(BeritaModel data) async {
    try {
      final datatoupdate = data.toJson();
      datatoupdate.remove('id');
      datatoupdate.remove('createdAt');
      await supabase.from('Berita').update(datatoupdate).eq('id', data.id);
    } catch (e) {
      throw Exception("gagal mengambil berita di remote source $e");
    }
  }
}
