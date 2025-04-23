import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'article_model.g.dart';

class Article {
  final String title;
  final String link;
  final String domain;
  final DateTime date;
  final String image;
  final String imageCaption;

  Article({
    required this.title,
    required this.link,
    required this.domain,
    required this.date,
    required this.image,
    required this.imageCaption,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] as String? ?? '',
      link: json['link'] as String? ?? '',
      domain: json['domain'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      image: json['image'] as String? ?? '',
      imageCaption: json['imageCaption'] as String? ?? '',
    );
  }
}

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 2;

  @override
  Article read(BinaryReader reader) {
    return Article(
      title: reader.readString(),
      link: reader.readString(),
      domain: reader.readString(),
      date: DateTime.parse(reader.readString()),
      image: reader.readString(),
      imageCaption: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.link);
    writer.writeString(obj.domain);
    writer.writeString(obj.date.toIso8601String());
    writer.writeString(obj.image);
    writer.writeString(obj.imageCaption);
  }
}
