import 'package:hive/hive.dart';
import 'package:kite_news/data/models/cluster_model.dart';

class KiteNews {
  final String category;
  final int timestamp;
  final int read;
  final List<Cluster> clusters;

  KiteNews({
    required this.category,
    required this.timestamp,
    required this.read,
    required this.clusters,
  });

  factory KiteNews.fromJson(Map<String, dynamic> json) {
    return KiteNews(
      category: json['category'] as String ?? "",
      timestamp: json['timestamp'] as int ?? 0,
      read: json['read'] as int,
      clusters: (json['clusters'] as List<dynamic>? ?? [])
          .map((e) => Cluster.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
 
}

class KiteNewsAdapter extends TypeAdapter<KiteNews> {
  @override
  final int typeId = 0;

  @override
  KiteNews read(BinaryReader reader) {
    return KiteNews(
      category: reader.readString(),
      timestamp: reader.readInt(),
      read: reader.readInt(),
      clusters: reader.readList().cast<Cluster>(),
    );
  }

  @override
  void write(BinaryWriter writer, KiteNews obj) {
    writer.writeString(obj.category);
    writer.writeInt(obj.timestamp);
    writer.writeInt(obj.read);
    writer.writeList(obj.clusters);
  }
}
