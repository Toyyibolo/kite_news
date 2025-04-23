import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class Source {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  Source({required this.name, required this.url});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  
}
