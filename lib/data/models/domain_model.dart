import 'package:hive/hive.dart';

class Domain {
  final String name;
  final String favicon;

  Domain({required this.name, required this.favicon});

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      name: json['name'] as String? ?? '',
      favicon: json['favicon'] as String? ?? '',
    );
  }
}

class DomainAdapter extends TypeAdapter<Domain> {
  @override
  final int typeId = 3;

  @override
  Domain read(BinaryReader reader) {
    return Domain(
      name: reader.readString(),
      favicon: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Domain obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.favicon);
  }
}
