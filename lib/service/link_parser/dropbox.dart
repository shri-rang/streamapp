
class DropBox {
  Future<String> parseLink(String url) async {
    String tempUrl = "";
    if (url.contains("dl=0")) {
      tempUrl = url.replaceAll("dl=0", "dl=1");
    } else {
      tempUrl = "$url?dl=1";
    }
    return tempUrl;
  }
}
