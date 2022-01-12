// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class APIService {
  static Future<Map<String, dynamic>> listOfContinentsByName() async {
    try {
      final http.Response _apiResponse = await http.get(Uri.parse(
          "http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso/ListOfContinentsByName"));
      if (_apiResponse.statusCode == 200) {
        print(_apiResponse.body);
        final document = XmlDocument.parse(_apiResponse.body);
        final List<String> codes =
            document.findAllElements('sCode').map((e) => e.text).toList();
        final List<String> names =
            document.findAllElements('sName').map((e) => e.text).toList();
        for (var element in codes) {
          print(element);
        }
        for (var element in names) {
          print(element);
        }
        return {
          'code': _apiResponse.statusCode,
          'message': 'Data fetched successfully',
          'codes': codes,
          'names': names
        };
      } else {
        return {
          'code': _apiResponse.statusCode,
          'message': 'Error in fetching the data'
        };
      }
    } on Exception catch (e) {
      return {'code': 501, 'message': 'Error in fetching the data\n$e'};
    }
  }
}
