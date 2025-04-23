import 'package:hive/hive.dart';
import 'package:kite_news/data/models/source_model.dart';

//part 'perspective_model.g.dart';

class Perspective {
  final String text;
  final List<Source> sources;

  Perspective({required this.text, required this.sources});

  factory Perspective.fromJson(Map<String, dynamic> json) {
    return Perspective(
      text: json['text'] as String,
      sources: (json['sources'] as List<dynamic>? ?? [])
          .map((source) => Source.fromJson(source as Map<String, dynamic>))
          .toList(),
    );
  }
}
 

class PerspectiveAdapter extends TypeAdapter<Perspective> {
  @override
  final int typeId = 4;

  @override
  Perspective read(BinaryReader reader) {
    return Perspective(
      text: reader.readString(),
      sources: reader.readList().cast<Source>(),
    );
  }

  @override
  void write(BinaryWriter writer, Perspective obj) {
    writer.writeString(obj.text);
    writer.writeList(obj.sources);
  }
}
