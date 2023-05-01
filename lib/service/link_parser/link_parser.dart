
import 'package:oxoo/service/link_parser/daily_motion.dart';
import 'package:oxoo/service/link_parser/dropbox.dart';
import 'package:oxoo/service/link_parser/tubi.dart';
import 'package:oxoo/service/link_parser/vimeo.dart';


class LinkParser {
  Future<String> getPlayableLink({
    required String linkType,
    required String url,
  }) async {
    switch (linkType) {
      case "dailymotion":
        String? link = await DailyMotion().parseDailyMotionLink(url);
        return link;
      case "vimeo":
        String? link = await Vimeo().parseLink(url);
        return link;
      case "tubitv":
        String? link = await Tubi().parseLink(url);
        return link;
      case "dropbox":
        String? link = await DropBox().parseLink(url);
        return link;
      default:
        return url;
    }
  }
}
