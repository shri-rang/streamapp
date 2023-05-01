class Videos {
  String? videoFileId;
  String? label;
  String? streamKey;
  String? fileType;
  String? fileUrl;
  List<Subtitle>? subtitle;

  Videos({
    this.videoFileId,
    this.label,
    this.streamKey,
    this.fileType,
    this.fileUrl,
    this.subtitle,
  });

  Videos.fromJson(Map<String, dynamic> json) {
    videoFileId = json['video_file_id'];
    label = json['label'];
    streamKey = json['stream_key'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
    subtitle =
        List.from(json['subtitle']).map((e) => Subtitle.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_file_id'] = this.videoFileId;
    data['label'] = this.label;
    data['stream_key'] = this.streamKey;
    data['file_type'] = this.fileType;
    data['file_url'] = this.fileUrl;
    data['subtitle'] =
        subtitle != null ? subtitle!.map((e) => e.toJson()).toList() : null;
    return data;
  }
}

class Subtitle {
  Subtitle({
    required this.subtitleId,
    required this.videosId,
    required this.videoFileId,
    required this.language,
    required this.kind,
    required this.url,
    required this.srclang,
  });
  late final String subtitleId;
  late final String videosId;
  late final String videoFileId;
  late final String language;
  late final String kind;
  late final String url;
  late final String srclang;

  Subtitle.fromJson(Map<String, dynamic> json) {
    subtitleId = json['subtitle_id'];
    videosId = json['videos_id'];
    videoFileId = json['video_file_id'];
    language = json['language'];
    kind = json['kind'];
    url = json['url'];
    srclang = json['srclang'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subtitle_id'] = subtitleId;
    _data['videos_id'] = videosId;
    _data['video_file_id'] = videoFileId;
    _data['language'] = language;
    _data['kind'] = kind;
    _data['url'] = url;
    _data['srclang'] = srclang;
    return _data;
  }
}
