import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/screen/tv_series/tv_series_details_screen.dart';
import 'package:provider/provider.dart';
import '../../models/home_content.dart';
import '../../models/user_model.dart';
import '../../screen/live_tv_details_screen.dart';
import '../../screen/movie_screen.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../service/authentication_service.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../movie/paid_controll_dialog.dart';

// ignore: must_be_immutable
class HomeScreenMovieList extends StatefulWidget {
  List<Movie>? latestMovies;
  final String? title;
  final bool isSearchWidget;
  final bool? isDark;
  final bool? isLength;

  HomeScreenMovieList(
      {required this.latestMovies,
      this.isLength,
      this.context,
      this.title,
      this.isSearchWidget = false,
      this.isDark});
  var context;

  @override
  State<HomeScreenMovieList> createState() => _HomeScreenMovieListState();
}

class _HomeScreenMovieListState extends State<HomeScreenMovieList> {
  double? cardWidth;
  var appModeBox = Hive.box('appModeBox');
  bool isUserValidSubscriber = false;
   int? currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width / 3.1;
    final authService = Provider.of<AuthService>(context);
    AuthUser? authUser = authService.getUser();
    isUserValidSubscriber = appModeBox.get('isUserValidSubscriber') ?? false;
    print("isUserValidSubscriber $isUserValidSubscriber");
    return Container(
        color: widget.isDark! ? CustomTheme.primaryColorDark : null,
        padding: EdgeInsets.only(left: 2),
        height:
         widget.title == "Coming Soon" ?  33.h
         :
         0.30.sh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title!,
                    textAlign: TextAlign.start,
                    style:
                        //  TextStyle(fontSize: 20, color: Colors.white)

                        widget.isDark!
                            ? CustomTheme.bodyText2White
                            : widget.isSearchWidget
                                ? CustomTheme.bodyText2
                                : CustomTheme.coloredBodyText2,
                  ),
                  Spacer(),
                  if (!widget.isSearchWidget)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MoviesScreen.route,
                            arguments: true);
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: CustomTheme.amber_800),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 25,
                            color: CustomTheme.amber_800,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child:
  
               
              
               widget.title == "New Releases"
                  ? Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            widget.latestMovies![index].thumbnailUrl!,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      itemCount: widget.latestMovies!.length,
                      itemWidth: 300.0,
                      // viewportFraction: 0.9,
                      containerWidth: 100,
                      layout: SwiperLayout.STACK,
                    )
                  : 
          
        
                  
                  widget.title == "Trending On Yellow"
                      ? Container(
                          color: CustomTheme.amber_800,
                          height: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                //  list!.length,
                                widget.latestMovies!.length <= 6
                                    ? widget.latestMovies!.length
                                    : 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 10),
                                  child: Container(
                                    width: cardWidth,
                                    // height:,
                                    // margin: EdgeInsets.only(right: 4, left: 3),
                                    child: InkWell(
                                      onTap: () {
                                        print(widget
                                            .latestMovies![index].videosId);
                                        // if (isUserValidSubscriber ||
                                        //     widget.latestMovies![index]
                                        //             .isPaid ==
                                        //         "0") {
                                        if (widget.latestMovies![index]
                                                .isTvseries ==
                                            "1") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TvSerisDetailsScreen(
                                                seriesID: widget
                                                    .latestMovies![index]
                                                    .videosId,
                                                isPaid: widget
                                                    .latestMovies![index]
                                                    .isPaid,
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.pushNamed(
                                              context, MovieDetailScreen.route,
                                              arguments: {
                                                "movieID": widget
                                                    .latestMovies![index]
                                                    .videosId
                                              });
                                        }

                                        // } else {
                                        //   PaidControllDialog().createDialog(
                                        //       context,
                                        //       widget.isDark!,
                                        //       authUser!.userId.toString(),
                                        //       widget.latestMovies![index]
                                        //           .videosId!);
                                        // }
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Container(
                                                  height: 190,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: CustomTheme
                                                            .amber_800),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    // child: Image.network(
                                                    //   latestMovies![index].thumbnailUrl!,
                                                    //   fit: BoxFit.fitWidth,
                                                    //   height: 155,
                                                    // ),
                                                    child: Image.network(
                                                        // placeholder:
                                                        //     "assets/images/placeholder.png",
                                                        // placeholderScale: 25,
                                                        // height: 180,
                                                        fit: BoxFit.fitHeight,
                                                        // imageErrorBuilder:
                                                        //     (context, error, stackTrace) =>
                                                        //         Image.asset(
                                                        //           "assets/images/placeholder.png",
                                                        //           fit: BoxFit.cover,
                                                        //         ),
                                                        // image:
                                                        widget
                                                            .latestMovies![
                                                                index]
                                                            .thumbnailUrl!),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 10,
                                                // ),
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 2),
                                                    padding: EdgeInsets.only(
                                                        right: 2,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Text(
                                                        //   latestMovies![index]
                                                        //       .title!,
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        //   style: isDark!
                                                        //       ? CustomTheme
                                                        //           .smallTextWhite
                                                        //           .copyWith(
                                                        //               fontWeight:
                                                        //                   FontWeight
                                                        //                       .bold,
                                                        //               fontSize:
                                                        //                   15,
                                                        //               color: CustomTheme
                                                        //                   .whiteColor)
                                                        //       : CustomTheme
                                                        //           .smallText
                                                        //           .copyWith(
                                                        //               fontSize:
                                                        //                   13),
                                                        // ),
                                                        // Row(
                                                        //   children: [
                                                        //     Text(latestMovies![index].videoQuality!,
                                                        //         textAlign: TextAlign.start,
                                                        //         style: isDark!
                                                        //             ? CustomTheme.smallTextWhite
                                                        //             : CustomTheme.smallText),
                                                        //     Expanded(
                                                        //       child: Text(
                                                        //           latestMovies![index].release!,
                                                        //           textAlign: TextAlign.end,
                                                        //           style: isDark!
                                                        //               ? CustomTheme.smallTextWhite
                                                        //               : CustomTheme.smallText),
                                                        //     ),
                                                        //   ],
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 4.h,
                                    right: 71.w,
                                    // left: 0,
                                    child: Text(" ${index + 1} ",
                                        style: TextStyle(
                                            fontFamily: 'Sans Serif',
                                            fontSize: 60,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ),
                        )
                      :
                      // title == "Yellow Originals"
                      //     ? Container(
                      //         color: CustomTheme.amber_800,
                      //         child: ListView.builder(
                      //           shrinkWrap: true,
                      //           itemCount:
                      //               //  list!.length,
                      //               latestMovies!.length <= 6
                      //                   ? latestMovies!.length
                      //                   : 6,
                      //           scrollDirection: Axis.horizontal,
                      //           itemBuilder: (context, index) => Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 6, vertical: 10),
                      //             child: Container(
                      //               width: cardWidth,
                      //               margin: EdgeInsets.only(right: 4, left: 3),
                      //               child: InkWell(
                      //                 onTap: () {
                      //                   print(latestMovies![index].videosId);

                      //                   if (latestMovies![index].isTvseries ==
                      //                       "1") {
                      //                     Navigator.push(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                         builder: (context) =>
                      //                             TvSerisDetailsScreen(
                      //                           seriesID: latestMovies![index]
                      //                               .videosId,
                      //                           isPaid:
                      //                               latestMovies![index].isPaid,
                      //                         ),
                      //                       ),
                      //                     );
                      //                   } else {
                      //                     Navigator.pushNamed(
                      //                         context, MovieDetailScreen.route,
                      //                         arguments: {
                      //                           "movieID": latestMovies![index]
                      //                               .videosId
                      //                         });
                      //                   }
                      //                 },
                      //                 child: ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(5.0),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(3.0),
                      //                       child: Column(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.stretch,
                      //                         children: <Widget>[
                      //                           Container(
                      //                             height: 190,
                      //                             decoration: BoxDecoration(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       16),
                      //                               border: Border.all(
                      //                                   width: 1,
                      //                                   color: CustomTheme
                      //                                       .amber_800),
                      //                             ),
                      //                             child: ClipRRect(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       16),
                      //                               // child: Image.network(
                      //                               //   latestMovies![index].thumbnailUrl!,
                      //                               //   fit: BoxFit.fitWidth,
                      //                               //   height: 155,
                      //                               // ),
                      //                               child: Image.network(
                      //                                   // placeholder:
                      //                                   //     "assets/images/placeholder.png",
                      //                                   // placeholderScale: 25,
                      //                                   // height: 180,
                      //                                   fit: BoxFit.fitHeight,
                      //                                   // imageErrorBuilder:
                      //                                   //     (context, error, stackTrace) =>
                      //                                   //         Image.asset(
                      //                                   //           "assets/images/placeholder.png",
                      //                                   //           fit: BoxFit.cover,
                      //                                   //         ),
                      //                                   // image:
                      //                                   latestMovies![index]
                      //                                       .thumbnailUrl!),
                      //                             ),
                      //                           ),
                      //                           // SizedBox(
                      //                           //   height: 10,
                      //                           // ),
                      //                           Center(
                      //                             child: Container(
                      //                               margin: EdgeInsets.only(
                      //                                   left: 2),
                      //                               padding: EdgeInsets.only(
                      //                                   right: 2,
                      //                                   top: 2,
                      //                                   bottom: 2),
                      //                               child: Column(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .start,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .start,
                      //                                 children: [
                      //                                   // Text(
                      //                                   //   latestMovies![index]
                      //                                   //       .title!,
                      //                                   //   overflow: TextOverflow
                      //                                   //       .ellipsis,
                      //                                   //   style: isDark!
                      //                                   //       ? CustomTheme
                      //                                   //           .smallTextWhite
                      //                                   //           .copyWith(
                      //                                   //               fontWeight:
                      //                                   //                   FontWeight
                      //                                   //                       .bold,
                      //                                   //               fontSize:
                      //                                   //                   15,
                      //                                   //               color: CustomTheme
                      //                                   //                   .whiteColor)
                      //                                   //       : CustomTheme
                      //                                   //           .smallText
                      //                                   //           .copyWith(
                      //                                   //               fontSize:
                      //                                   //                   13),
                      //                                   // ),
                      //                                   // Row(
                      //                                   //   children: [
                      //                                   //     Text(latestMovies![index].videoQuality!,
                      //                                   //         textAlign: TextAlign.start,
                      //                                   //         style: isDark!
                      //                                   //             ? CustomTheme.smallTextWhite
                      //                                   //             : CustomTheme.smallText),
                      //                                   //     Expanded(
                      //                                   //       child: Text(
                      //                                   //           latestMovies![index].release!,
                      //                                   //           textAlign: TextAlign.end,
                      //                                   //           style: isDark!
                      //                                   //               ? CustomTheme.smallTextWhite
                      //                                   //               : CustomTheme.smallText),
                      //                                   //     ),
                      //                                   //   ],
                      //                                   // )
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           )
                      //                         ],
                      //                       ),
                      //                     )),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     :
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              //  list!.length,
                              widget.latestMovies!.length <= 6
                                  ? widget.latestMovies!.length
                                  : 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: cardWidth,
                            margin: EdgeInsets.only(right: 2),
                            child: InkWell(
                              onTap: () {
                                print(widget.latestMovies![index].videosId);

                                // if (isUserValidSubscriber ||
                                //     widget.latestMovies![index].isPaid == "0") {
                                if (widget.latestMovies![index].isTvseries ==
                                    "1") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TvSerisDetailsScreen(
                                        seriesID: widget
                                            .latestMovies![index].videosId,
                                        isPaid:
                                            widget.latestMovies![index].isPaid,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.pushNamed(
                                      context, MovieDetailScreen.route,
                                      arguments: {
                                        "movieID":
                                            widget.latestMovies![index].videosId
                                      });
                                }
                                //  }
                                //  else {
                                //   PaidControllDialog().createDialog(
                                //       context,
                                //       widget.isDark!,
                                //       authUser!.userId.toString(),
                                //       widget.latestMovies![index].videosId!);
                                // }
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          height: 190,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                width: 1,
                                                color: CustomTheme.amber_800),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            // child: Image.network(
                                            //   latestMovies![index].thumbnailUrl!,
                                            //   fit: BoxFit.fitWidth,
                                            //   height: 155,
                                            // ),
                                            child: Image.network(
                                                // placeholder:
                                                //     "assets/images/placeholder.png",
                                                // placeholderScale: 25,
                                                // height: 180,
                                                fit: BoxFit.contain,
                                                // imageErrorBuilder:
                                                //     (context, error, stackTrace) =>
                                                //         Image.asset(
                                                //           "assets/images/placeholder.png",
                                                //           fit: BoxFit.cover,
                                                //         ),
                                                // image:
                                                widget.latestMovies![index]
                                                    .thumbnailUrl!),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 2),
                                            padding: EdgeInsets.only(
                                                right: 2, top: 2, bottom: 2),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   latestMovies![index]
                                                //       .title!,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: isDark!
                                                //       ? CustomTheme
                                                //           .smallTextWhite
                                                //           .copyWith(
                                                //               fontSize: 14,
                                                //               color: CustomTheme
                                                //                   .amber_800)
                                                //       : CustomTheme
                                                //           .smallText
                                                //           .copyWith(
                                                //               fontSize: 13),
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(latestMovies![index].videoQuality!,
                                                //         textAlign: TextAlign.start,
                                                //         style: isDark!
                                                //             ? CustomTheme.smallTextWhite
                                                //             : CustomTheme.smallText),
                                                //     Expanded(
                                                //       child: Text(
                                                //           latestMovies![index].release!,
                                                //           textAlign: TextAlign.end,
                                                //           style: isDark!
                                                //               ? CustomTheme.smallTextWhite
                                                //               : CustomTheme.smallText),
                                                //     ),
                                                //   ],
                                                // )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        // : Container()
            ),
          ],
        ));
  }
}

class Movies {
  String? name;
  String? image;

  Movies({this.image, this.name});
}
