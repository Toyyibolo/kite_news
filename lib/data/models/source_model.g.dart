// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceAdapter extends TypeAdapter<Source> {
  @override
  final int typeId = 5;

  @override
  Source read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Source(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Source obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
  name: json['name'] as String? ?? '',
  url: json['url'] as String? ?? '',
    );


