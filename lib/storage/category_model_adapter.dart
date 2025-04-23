import 'package:hive/hive.dart';
import 'package:kite_news/data/models/kite_category_model.dart';

//part 'category_model_adapter.g.dart'

// Category Adapter
@HiveType(typeId: 6)  
class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 6;

  @override
  Category read(BinaryReader reader) {
    final name = reader.readString();
    final file = reader.readString();
    return Category(name: name, file: file);
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.file);
  }
}
