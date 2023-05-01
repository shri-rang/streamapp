import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:oxoo/models/video_comments/ad_comments_model.dart';
import 'package:oxoo/models/video_comments/all_comments_model.dart';
import 'package:oxoo/models/videos.dart';
import 'package:oxoo/utils/validators.dart';
import 'package:oxoo/widgets/player/embed_player.dart';
import 'package:oxoo/widgets/player/flick_player.dart';
import '../../screen/auth/auth_screen.dart';
import '../../screen/subscription/premium_subscription_screen.dart';
import '../../utils/button_widget.dart';
import '../../widgets/movie/movie_details_youtube_player.dart';
import '../../widgets/tv_series/related_tvseries_card.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../models/configuration.dart';
import '../../models/tv_series_details_model.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../service/get_config_service.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/share_btn.dart';
import '../../widgets/tv_series/cast_crew_item_card.dart';
import '../../widgets/tv_series/episode_item_card.dart';
import '../../constants.dart';
import '../../strings.dart';
import '../movie/movie_reply_screen.dart';

class TvSerisDetailsScreen extends StatefulWidget {
  final String? seriesID;
  final String? isPaid;
  const TvSerisDetailsScreen(
      {Key? key, required this.seriesID, required this.isPaid})
      : super(key: key);
  @override
  _TvSerisDetailsScreenState createState() => _TvSerisDetailsScreenState();
}

class _TvSerisDetailsScreenState extends State<TvSerisDetailsScreen> {
  TextEditingController editingController = new TextEditingController();
  //Season? selectedSeason;
  String? selectedSeasonName;
  final ValueNotifier<String> currentSeasonId = ValueNotifier<String>("");
  final ValueNotifier<Season?> selectedSeason = ValueNotifier<Season?>(null);
  bool isSeriesPlaying = false;
  String? _url;
  String? _fileType;
  List<Subtitle>? subtitles = [];
  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');
  bool isLoadingBraintree = false;
  AuthUser? authUser = AuthService().getUser();
  bool isUserValidSubscriber = false;
  late Future<TvSeriesDetailsModel?> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = Repository().getTvSeriesDetailsData(
        seriesId: widget.seriesID,
        userId: authUser != null ? authUser!.userId.toString() : null);
    isDark = appModeBox.get('isDark') ?? false;

    isUserValidSubscriber = appModeBox.get('isUserValidSubscriber') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_TvSerisDetailsScreenState");

    final configService = Provider.of<GetConfigService>(context);
    PaymentConfig? paymentConfig = configService.paymentConfig();

    return Scaffold(
        backgroundColor:
            isDark! ? CustomTheme.colorAccentDark : CustomTheme.whiteColor,
        body: FutureBuilder<TvSeriesDetailsModel?>(
            future: dataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                TvSeriesDetailsModel data = snapshot.data!;
                //selectedSeason = data.season!.first;
                if (data.season!.length > 0) {
                  selectedSeasonName = data.season!.first.seasonsName!;
                  currentSeasonId.value = data.season!.first.seasonsId!;
                }

                return buildUI(
                  context,
                  data,
                  authUser,
                  paymentConfig,
                  data.videosId,
                );
              }

              return Center(child: spinkit);
            }));
  }

  ///build subscriptionInfo Dialog
  Widget subscriptionInfoDialog(
      {required BuildContext context, required bool isDark, String? userId}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? CustomTheme.darkGrey : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppContent.youNeedPremium,
                  style: CustomTheme.authTitle,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomTheme.primaryColor,
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PremiumSubscriptionScreen(
                                  fromRadioScreen: false,
                                  fromLiveTvScreen: true,
                                  liveTvID: "1",
                                  isPaid: widget.isPaid)),
                        );
                      },
                      child: Text(
                        "subscribe to Premium",
                        style: CustomTheme.bodyText3White,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomTheme.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppContent.goBack,
                          style: CustomTheme.bodyText3White),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUI(BuildContext context, TvSeriesDetailsModel? details,
      AuthUser? authUser, PaymentConfig? paymentConfig, String? videoId) {
    return Container(
      color: isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 330.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            image: DecorationImage(
                              image: NetworkImage(details!.posterUrl!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 330.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black87,
                                Colors.black87,
                                isDark! ? Colors.black : Colors.white,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          width: 140,
                          height: 200.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              image: DecorationImage(
                                  image: NetworkImage(details.thumbnailUrl!),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          height: 200.0,
                          alignment: Alignment.bottomLeft,
                          margin: new EdgeInsets.only(left: 10),
                          width: 150.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                details.title!,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              HelpMe().space(8.0),
                              Text(
                                details.slug!,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      ShareApp(
                        title: details.title,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
            HelpMe().space(20.0),
            if (details.season!.length > 0)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: MediaQuery.of(context).size.width,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                        valueListenable: selectedSeason,
                        builder: (context, value, child) {
                          return DropdownButton<Season>(
                            value: value,
                            hint: Text(
                              "Season: " + selectedSeasonName!,
                              style: TextStyle(color: Colors.white),
                            ),
                            isExpanded: true,
                            underline: Container(
                              width: 0.0,
                              height: 0.0,
                            ),
                            onChanged: (newValue) {
                              selectedSeason.value = newValue;
                              currentSeasonId.value = newValue!.seasonsId!;
                            },
                            items: details.season!
                                .map<DropdownMenuItem<Season>>((season) {
                              return DropdownMenuItem<Season>(
                                value: season,
                                child: Text(
                                  "Season: " + season.seasonsName!,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                ),
              ),
            ValueListenableBuilder<String>(
              valueListenable: currentSeasonId,
              builder: (context, value, child) {
                printLog("----------onChanged: $value");

                return buildEpisodeListView(value, details);
              },
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(details.description!,
                  style: isDark!
                      ? CustomTheme.bodyText2White
                      : CustomTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppContent.director,
                style: isDark!
                    ? CustomTheme.bodyText1BoldWhite
                    : CustomTheme.bodyText1Bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${AppContent.releaseOn} 2001-11-05",
                style: isDark!
                    ? CustomTheme.bodyText1BoldWhite
                    : CustomTheme.bodyText1Bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppContent.genre,
                style: isDark!
                    ? CustomTheme.bodyText1BoldWhite
                    : CustomTheme.bodyText1Bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppContent.castCrew,
                style: isDark!
                    ? CustomTheme.bodyText1BoldWhite
                    : CustomTheme.bodyText1Bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 110.0,
              child: ListView.builder(
                  itemCount: details.castAndCrew!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return CastCrewCard(
                      castAndCrew: details.castAndCrew!.elementAt(index),
                      isDark: isDark,
                    );
                  }),
            ),
            if (details.relatedTvseries!.length > 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppContent.youMayAlsoLike,
                  style: isDark!
                      ? CustomTheme.bodyText1BoldWhite
                      : CustomTheme.bodyText1Bold,
                ),
              ),
            if (details.relatedTvseries!.length > 0)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 200.0,
                child: ListView.builder(
                    itemCount: details.relatedTvseries!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RelatedTvSerisCard(
                          relatedTvseries:
                              details.relatedTvseries!.elementAt(index),
                          isDark: isDark,
                        ),
                      );
                    }),
              ),
            //comment
            if (authUser != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppContent.comments,
                  style: isDark!
                      ? CustomTheme.bodyText1BoldWhite
                      : CustomTheme.bodyText1Bold,
                ),
              ),
            if (authUser != null)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: isDark!
                      ? CustomTheme.bodyText2White
                      : CustomTheme.bodyText2,
                  controller: editingController,
                  decoration: InputDecoration(
                    hintText: AppContent.yourComments,
                    filled: true,
                    hintStyle: CustomTheme.bodyTextgray2,
                    fillColor: isDark! ? Colors.black54 : Colors.grey.shade200,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 0.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 0.0),
                    ),
                  ),
                ),
              ),
            //add comment button
            if (authUser != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: isDark!
                          ? CustomTheme.grey_transparent2
                          : Colors.grey.shade300,
                    ),
                    onPressed: () {
                      postComment(details);
                    },
                    child: Text(
                      AppContent.addComments,
                      style: TextStyle(color: CustomTheme.primaryColor),
                    ),
                  ),
                ),
              ),
            if (authUser != null)
              SizedBox(
                child: FutureBuilder<AllCommentModelList?>(
                  future: Repository().getAllComments(videoId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      AllCommentModelList list = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list.commentsList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return commentItem(list.commentsList![index]);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  void postComment(TvSeriesDetailsModel data) async {
    String comment = editingController.text.toString();
    if (comment.isNotEmpty) {
      AddCommentsModel? model = await Repository()
          .addComments(data.videosId, authUser!.userId, comment);

      if (model != null) {
        editingController.clear();
        showShortToast(model.message ?? "");
        setState(() {});
      }
    }
  }

  Widget commentItem(AllCommentModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Card(
        color: isDark! ? CustomTheme.colorAccentDark : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Image.network(
                  model.userImgUrl!,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              SizedBox(width: 10.0),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.userName!,
                      style: isDark!
                          ? CustomTheme.bodyText2White
                          : CustomTheme.bodyTextgray2,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      model.comments!,
                      style: CustomTheme.smallTextGrey,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MovieReplyScreen.route,
                              arguments: {
                                'commentsID': model.commentsId,
                                'videosID': model.videosId,
                                'userId': "1",
                                'isDark': true,
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(AppContent.reply,
                              style: CustomTheme.coloredBodyText3),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEpisodeListView(String? id, TvSeriesDetailsModel data) {
    if (data.season!.length == 0) return Container();
    Season? season =
        data.season!.where((element) => element.seasonsId == id).first;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: season.episodes!.length > 0 ? 170.0 : 0,
      child: ListView.builder(
          itemCount: season.episodes!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                print("tapped_on_episodeItem_card");
                _url = season.episodes![index].fileUrl;
                _fileType = season.episodes![index].fileType;
                subtitles = season.episodes![index].subtitle;
                isSeriesPlaying = true;

                openVideoPlayer(_fileType ?? "mp4", season.episodes![index]);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: EpisodeItemCard(
                  episodeName: season.episodes!.elementAt(index).episodesName,
                  imagePath: season.episodes!.elementAt(index).imageUrl,
                  isDark: isDark,
                ),
              ),
            );
          }),
    );
  }

  void openVideoPlayer(String type, Episodes episode) {
    if (type.contains("embed")) {
      //open embed player
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmbedPlayer(url: episode.fileUrl!)));
    } else if (type.contains("youtube")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MovieDetailsYoutubePlayer(url: episode.fileUrl!)));
    } else {
      _url = episode.fileUrl;
      _fileType = episode.fileType;
      subtitles = episode.subtitle;
      isSeriesPlaying = true;

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FlickPlayer(
          type: _fileType!,
          url: _url!,
          subtitles: subtitles,
        ),
      ));
    }
  }
}
