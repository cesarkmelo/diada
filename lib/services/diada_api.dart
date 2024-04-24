import 'package:diada/services/networking.dart';

const diadaApiUrl = 'https://diada.alfamediaweb.com/auth2.php';

class DiadaModel {
  Future<dynamic> getAnyFieldById(String firebaseId, String field) async {
    Object body = {'id_firebase': firebaseId, 'field': field, 'get': ''};
    NetworkHelper networkHelper = NetworkHelper(diadaApiUrl, body);
    var resultsData = await networkHelper.getData();
    return resultsData[field];
  }

  Future<dynamic> getReversedDataFieldById(
      String firebaseId, String field) async {
    Object body = {
      'id_firebase': firebaseId,
      'field': field,
      'getCalcLastData': ''
    };
    NetworkHelper networkHelper = NetworkHelper(diadaApiUrl, body);
    var resultsData = await networkHelper.getData();
    return resultsData[field];
  }

  Future<dynamic> storeResultById(
      String firebaseId, String field, String value) async {
    Object body = {
      'id_firebase': firebaseId,
      'field': field,
      'value': value,
      'add_field': ''
    };
    NetworkHelper networkHelper = NetworkHelper(diadaApiUrl, body);
    var resultsData = await networkHelper.storeData();
    return resultsData[field];
  }

  Future<dynamic> storeProfileById(Object body) async {
    NetworkHelper networkHelper = NetworkHelper(diadaApiUrl, body);
    var resultsData = await networkHelper.storeData();
    return resultsData;
  }

  Future<dynamic> getDataById(String firebaseId) async {
    Object body = {'id_firebase': firebaseId, 'get_data': ''};
    NetworkHelper networkHelper = NetworkHelper(diadaApiUrl, body);
    var resultsData = await networkHelper.getData();
    return resultsData;
  }
}
