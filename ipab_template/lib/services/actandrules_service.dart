import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ipab_template/classes/actandrules_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

const String url =
    "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/lCROkrBusRactandrules.json";

// ignore: missing_return
Future<List<ARdata>> getActAndRulesList() async {
  String fileName = "actandrulesdata.json";

  var dir = await getTemporaryDirectory();

  File file = new File(dir.path + "/" + fileName);
  bool result = await DataConnectionChecker().hasConnection;
  if (result == true) {
    print('connected');
    try {
      print("Loading from API");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var listofdata = response.body;
        List<ARdata> list = parseUsers(listofdata);
        file.writeAsStringSync(listofdata, flush: true, mode: FileMode.write);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  } else if (file.existsSync()) {
    print("Loading from cache");
    var jsonData = file.readAsStringSync();
    List<ARdata> list = parseUsers(jsonData);
    return list;
  } else {
    print("App first time loaded. So please on mobile data.");
  }
}

List<ARdata> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<ARdata>((json) => ARdata.fromJson(json)).toList();
}
