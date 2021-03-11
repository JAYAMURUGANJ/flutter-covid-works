import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class Services {
  static const String url = "https://jsonplaceholder.typicode.com/users";

  // ignore: missing_return
  static Future<List<User>> getUsers() async {
    String fileName = "userdata.json";

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
          List<User> list = parseUsers(listofdata);
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
      List<User> list = parseUsers(jsonData);
      return list;
    } else {
      print("App first time loaded. So please on mobile data.");
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
