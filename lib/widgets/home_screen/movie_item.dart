import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/screen/tv_series/tv_series_details_screen.dart';
import '../../models/home_content.dart';
import '../../screen/movie_screen.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../strings.dart';
import '../../style/theme.dart';

// ignore: must_be_immutable
class HomeScreenMovieList extends StatelessWidget {
  List<Movie>? latestMovies;
  final String? title;
  final bool isSearchWidget;
  final bool? isDark;
  double? cardWidth;
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
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width / 3.1;
    return Container(
        color: isDark! ? CustomTheme.primaryColorDark : null,
        padding: EdgeInsets.only(left: 2),
        height: 0.34.sh,
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
                    title!,
                    textAlign: TextAlign.start,
                    style:
                        //  TextStyle(fontSize: 20, color: Colors.white)

                        isDark!
                            ? CustomTheme.bodyText2White
                            : isSearchWidget
                                ? CustomTheme.bodyText2
                                : CustomTheme.coloredBodyText2,
                  ),
                  Spacer(),
                  if (!isSearchWidget)
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: latestMovies!.length,
                //itemCount:latestMovies!.length<=6?latestMovies!.length:5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: cardWidth,
                  margin: EdgeInsets.only(right: 2),
                  child: InkWell(
                    onTap: () {
                      print(latestMovies![index].videosId);

                      if (latestMovies![index].isTvseries == "1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvSerisDetailsScreen(
                              seriesID: latestMovies![index].videosId,
                              isPaid: latestMovies![index].isPaid,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushNamed(context, MovieDetailScreen.route,
                            arguments: {
                              "movieID": latestMovies![index].videosId
                            });
                      }
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: 1, color: CustomTheme.amber_800),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  // child: Image.network(
                                  //   latestMovies![index].thumbnailUrl!,
                                  //   fit: BoxFit.fitWidth,
                                  //   height: 155,
                                  // ),
                                  child: FadeInImage.assetNetwork(
                                      placeholder:
                                          "assets/images/placeholder.png",
                                      placeholderScale: 25,
                                      height: 180,
                                      fit: BoxFit.fitWidth,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                                "assets/images/placeholder.png",
                                                fit: BoxFit.cover,
                                              ),
                                      image:
                                          latestMovies![index].thumbnailUrl!),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(left: 2),
                                  padding: EdgeInsets.only(
                                      right: 2, top: 2, bottom: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        latestMovies![index].title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: isDark!
                                            ? CustomTheme.smallTextWhite
                                                .copyWith(
                                                    fontSize: 14,
                                                    color:
                                                        CustomTheme.amber_800)
                                            : CustomTheme.smallText
                                                .copyWith(fontSize: 13),
                                      ),
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
            ),
          ],
        ));
  }
}
