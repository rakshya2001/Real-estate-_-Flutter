import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase {
  late Box box;
  List data = [];
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('test');
    return;
  }

  Future<List> getAllQuestions() async {
    await openBox();
    var myMap = box.toMap().values.toList();
    if (myMap.isEmpty) {
      data.add("empty");
    } else {
      data = myMap;
    }
    return data;
  }

  Future putData(data) async {
    await openBox();
    box.add(data);
  }
}
