import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _urls = 'http://192.168.1.6/api_tes';
  final String _url = 'http://192.168.1.6/api_tes';

  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  authData(data, apiUrl) async {
    var fullUrl = _urls + apiUrl;
    return await http.post(fullUrl, body: data
    );
  }

  getData(apiUrl) async {
    var fullUrl = _urls + apiUrl;
    this._getToken();
    return await http.get(Uri.encodeFull(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  getUrl(urlFIle) {
    return _url + urlFIle;
  }
}
