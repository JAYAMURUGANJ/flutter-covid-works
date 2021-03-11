import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ipab_template/classes/technicalMembers_class.dart';
import 'package:path_provider/path_provider.dart';

const String url =
    'https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/HAFicIeTnKtechnicalmember.json';

// ignore: missing_return
Future<List<TechnicalMembers>> fetchListOfTechnicalMembers() async {
  String fileName = "TechnicalMembers.json";

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
        List<TechnicalMembers> list = parseUsers(listofdata);
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
    List<TechnicalMembers> list = parseUsers(jsonData);
    return list;
  } else {
    print("App first time loaded. So please on mobile data.");
  }
}

List<TechnicalMembers> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<TechnicalMembers>((json) => TechnicalMembers.fromJson(json))
      .toList();
}
