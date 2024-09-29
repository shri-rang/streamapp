// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/screen/tv_series/tv_series_details_screen.dart';
import 'package:oxoo/widgets/player/flick_player.dart';
import '../../models/home_content.dart';
import '../../screen/live_tv_details_screen.dart';
import '../../screen/movie/movie_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../style/theme.dart';

// ignore: must_be_immutable
class ImageSlider extends StatefulWidget {
  HomeContentSlider? _slider;
  String? title;
  ImageSlider(this._slider, this.title);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<Slide>? _list;
  int? currentIndex = 0;

  List image = [
    "assets/poster.jpg",
    "assets/sairab.png",
    "assets/sindur.png",
    "assets/whatsapp.png"
  ];

  @override
  Widget build(BuildContext context) {
    _list = widget._slider!.slide;
    print("${widget.title} idddddddddd${widget._slider!.slide![0].id}");
    return widget.title == "Coming Soon"
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title!,
                      textAlign: TextAlign.start,
                      style:
                          //  TextStyle(fontSize: 20, color: Colors.white)

                          // isDark!
                          //     ?
                          //
                          CustomTheme.bodyText2White
                      //     : isSearchWidget
                      //         ?
                      //CustomTheme.bodyText2

                      //  :
                      // CustomTheme.coloredBodyText2,
                      ),
                  Spacer(),
                ],
              ),
              // Text(widget.title!,
              //     textAlign: TextAlign.start,
              //     style:
              //         //  TextStyle(fontSize: 20, color: Colors.white)

              //         // isDark!
              //         //     ? CustomTheme.bodyText2White
              //         //     : isSearchWidget
              //         //         ?
              //         CustomTheme.bodyText2
              //             .copyWith(color: CustomTheme.whiteColor)
              //     // :
              //     // CustomTheme.coloredBodyText2,
              //     ),
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  aspectRatio: 3,

                  // enlargeCenterPage: true,
                  autoPlay: true,

                  // enlargeStrategy: CenterPageEnlargeStrategy.height,
                  autoPlayInterval: Duration(seconds: 4),
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                  height: 0.33.sh,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: _list!.map((slide) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 2.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, MovieDetailScreen.route,
                            //     arguments: {"movieID": "9"});
                            switch (slide.actionType) {
                              case "movie":
                                Navigator.pushNamed(
                                    context, MovieDetailScreen.route,
                                    arguments: {"movieID": slide.actionId});
                                break;
                              case "tv":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LiveTvDetailsScreen(
                                      liveTvId: slide.actionId,
                                      isPaid: "0",
                                    ),
                                  ),
                                );
                                break;
                              case "tvseries":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TvSerisDetailsScreen(
                                      seriesID: slide.id,
                                      isPaid: '',
                                    ),
                                  ),
                                );
                                break;

                              default:
                                {
                                  printLog("Inside_others!");
                                }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              //    crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 0.27.sh,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 2, color: CustomTheme.amber_800),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        // if (slide.imageLink != null)
                                        Image.network(
                                          slide.imageLink!,
                                          // slide.imageLink!,
                                          fit: BoxFit.fitHeight,
                                        ),
                                        /*if(slide.thumbnailUrl != null)
                                  Image.network(
                                    slide.thumbnailUrl,
                                    fit: BoxFit.cover,
                                  ),*/
                                        //                             Container(
                                        //                               alignment: Alignment.bottomLeft,
                                        // //                        margin: EdgeInsets.only(left: 10, bottom: 10),
                                        //                               child: Padding(
                                        //                                 padding: const EdgeInsets.all(10.0),
                                        //                                 child: Text(
                                        //                                   slide.title!,
                                        //                                   style: TextStyle(
                                        //                                       color: Colors.purple, fontSize: 12),
                                        //                                 ),
                                        //                               ),
                                        //                             )
                                      ],
                                    ),
                                  ),
                                ),

                                // Text(
                                //   slide.title!,
                                //   style: TextStyle(
                                //       fontFamily: 'Sans Serif',
                                //       color: Colors.white,
                                //       fontSize: 20.sp,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Center(
                child: DotsIndicator(
                  decorator: DotsDecorator(activeColor: CustomTheme.amber_800),
                  dotsCount: _list!.length,
                  position: currentIndex!,
                ),
              )
            ],
          )
        : CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              aspectRatio: 1.0,

              // enlargeCenterPage: true,
              autoPlay: true,

              // enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayInterval: Duration(seconds: 4),
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              height: 0.43.sh,
            ),
            items: _list!.map((slide) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 2.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, MovieDetailScreen.route,
                        //     arguments: {"movieID": "9"});
                        switch (slide.actionType) {
                          case "movie":
                            Navigator.pushNamed(
                                context, MovieDetailScreen.route,
                                arguments: {"movieID": slide.actionId});
                            break;
                          case "tv":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveTvDetailsScreen(
                                  liveTvId: slide.actionId,
                                  isPaid: "0",
                                ),
                              ),
                            );
                            break;
                          case "tvseries":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TvSerisDetailsScreen(
                                  seriesID: slide.id,
                                  isPaid: '',
                                ),
                              ),
                            );
                            break;

                          default:
                            {
                              printLog("Inside_others!");
                            }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 0.38.sh,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    width: 2, color: CustomTheme.amber_800),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    // if (slide.imageLink != null)
                                    Image.network(
                                      slide.imageLink!,
                                      // slide.imageLink!,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    /*if(slide.thumbnailUrl != null)
                              Image.network(
                                slide.thumbnailUrl,
                                fit: BoxFit.cover,
                              ),*/
                                    //                             Container(
                                    //                               alignment: Alignment.bottomLeft,
                                    // //                        margin: EdgeInsets.only(left: 10, bottom: 10),
                                    //                               child: Padding(
                                    //                                 padding: const EdgeInsets.all(10.0),
                                    //                                 child: Text(
                                    //                                   slide.title!,
                                    //                                   style: TextStyle(
                                    //                                       color: Colors.purple, fontSize: 12),
                                    //                                 ),
                                    //                               ),
                                    //                             )
                                  ],
                                ),
                              ),
                            ),

                            // Text(
                            //   slide.title!,
                            //   style: TextStyle(
                            //       fontFamily: 'Sans Serif',
                            //       color: Colors.white,
                            //       fontSize: 20.sp,
                            //       fontWeight: FontWeight.bold),
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //    iconWTitle(Icons.bookmark_add_outlined, "My List"),
                                // GestureDetector(
                                //   onTap: () {
                                //     // Navigator.of(context).push(MaterialPageRoute(
                                //     //   builder: (context) {
                                //     //     return ChooseInterest();
                                //     //   },
                                //     // ));
                                //     // Get.to(LoginInput(type: "Sign Up"));
                                //   },
                                //   child: PrimaryButton(
                                //     title: "PLAY",
                                //     width: 100,
                                //     onTap: () {
                                //       switch (slide.actionType) {
                                //         case "movie":
                                //           Navigator.pushNamed(
                                //               context, MovieDetailScreen.route,
                                //               arguments: {"movieID": slide.actionId});
                                //           break;
                                //         case "tv":
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) =>
                                //                   LiveTvDetailsScreen(
                                //                 liveTvId: slide.actionId,
                                //                 isPaid: "0",
                                //               ),
                                //             ),
                                //           );
                                //           break;
                                //         case "tvseries":
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) =>
                                //                   TvSerisDetailsScreen(
                                //                 seriesID: slide.id,
                                //                 isPaid: '',
                                //               ),
                                //             ),
                                //           );
                                //           break;

                                //         default:
                                //           {
                                //             printLog("Inside_others!");
                                //           }
                                //       }
                                //     },
                                //     // screenWidth * .8,
                                //     height: 40,
                                //   ),
                                // ),
                                //      iconWTitle(Icons.download, "Download"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
  }

  iconWTitle(IconData icon, String title) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Sans Serif',
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
