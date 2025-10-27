import 'package:patroli_fakta/domain/entities/berita_entities.dart';

sealed class StatusProvider {}

class StatusIsloading extends StatusProvider {}

class IsuksesDetail extends StatusProvider {
  final BeritaEntities data;
  IsuksesDetail(this.data);
}

class Iserror extends StatusProvider {
  final String message;
  Iserror(this.message);
}

class Issuksesmessage extends StatusProvider {
  final String message;
  Issuksesmessage({required this.message});
}

class Isidle extends StatusProvider {}
