import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:offline_access/ResultCard/Document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class IpabServices {
  static const String url =
      "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/KjiEDtCJHQdocument.json";

  // ignore: missing_return
  static Future<List<Document>> getUsers() async {
    String fileName = "Document.json";

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
          List<Document> list = parseUsers(listofdata);
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
      List<Document> list = parseUsers(jsonData);
      return list;
    } else {
      print("App first time loaded. So please on mobile data.");
    }
  }

  static List<Document> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Document>((json) => Document.fromJson(json)).toList();
  }
}
