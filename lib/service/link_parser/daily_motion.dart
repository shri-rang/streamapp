import 'dart:convert';
import 'package:http/http.dart' as http;

class DailyMotion {
 
  Future<String> parseDailyMotionLink(String url) async {
    //https://www.dailymotion.com/video/x8cdfw7
    String apiUrl =
        "https://www.dailymotion.com/player/metadata/video/${_getDailyMotionId(url)}";

    final response =
        await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 10));
    String? link = jsonDecode(response.body)['qualities']['auto'][0]['url'];
    return link ?? "";
  }

  String _getDailyMotionId(String url) {
    var parts = url.split("/");
    var id = parts[4];
    return id;
  }
}
