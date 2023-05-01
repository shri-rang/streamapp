import 'dart:convert';
import 'package:http/http.dart' as http;

class Tubi {
  Future<String> parseLink(String url) async {
    String apiUrl = "https://tubitv.com/oz/videos/${_getId(url)}/content";

    final response =
        await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 10));
    var jsonResponse = jsonDecode(response.body);
    var videoResources = jsonResponse['video_resources'][0];
    var manifest = videoResources['manifest'];
    String? link = manifest['url'];
    return link ?? "";
  }

  String _getId(String url) {
    var parts = url.split("/");
    var id = parts[4];
    return id;
  }
}
