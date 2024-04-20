import 'package:carousel_slider/carousel_slider.dart';
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
class ImageSlider extends StatelessWidget {
  HomeContentSlider? _slider;
  ImageSlider(this._slider);
  List<Slide>? _list;

  @override
  Widget build(BuildContext context) {
    _list = _slider!.slide;
    return CarouselSlider(
      options: CarouselOptions(
        initialPage: 0,
        enableInfiniteScroll: true,
        aspectRatio: 1.0,

        // enlargeCenterPage: true,
        autoPlay: true,

        // enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlayInterval: Duration(seconds: 2),
        scrollDirection: Axis.horizontal,
        viewportFraction: 1,
        height: 0.43.sh,
      ),
      items: _list!.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
              child: InkWell(
                onTap: () {
                  switch (slide.actionType) {
                    case "movie":
                      Navigator.pushNamed(context, MovieDetailScreen.route,
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
                              if (slide.imageLink != null)
                                Image.asset(
                                  "assets/poster.jpg",
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
