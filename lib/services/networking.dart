import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelber {
  var url;

  NetworkHelber(this.url);

  getData() async {
    var localUrl = Uri.parse(url);
    Response response = await get(localUrl);
    var decodedData;
    if (response.statusCode == 200) {
      String data = response.body;
      print('Json from NetworkHelber : $data');
      decodedData = jsonDecode(data);
      var res = decodedData['main']['temp'];
      print("================$res   ===================");
      // the return type of this method is dynamic
    } else {
      print('response.statusCode : ${response.statusCode}');
    }
    return decodedData;
  }
}
