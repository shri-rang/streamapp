import 'package:flutter/material.dart';
import 'package:oxoo/models/home_content.dart';
import 'package:oxoo/screen/movies_by_star_id.dart';
import 'package:oxoo/strings.dart';
import 'package:oxoo/utils/button_widget.dart';

import '../../style/theme.dart';

class PopularStarWidget extends StatelessWidget {
  final bool isDark;
  final List<PopularStars> popularStars;
  const PopularStarWidget(
      {required this.isDark, required this.popularStars, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: isDark ? CustomTheme.primaryColorDark : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppContent.popularStars,
            textAlign: TextAlign.start,
            style: isDark
                ? CustomTheme.bodyText2White
                : CustomTheme.coloredBodyText2,
          ),
          HelpMe().space(5),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: popularStars.length,
              itemBuilder: (context, index) => InkResponse(
                onTap: () => Navigator.pushNamed(
                  context,
                  MoviesScreenByStarID.route,
                  arguments: {
                    'isPresentAppBar': true,
                    'starID': popularStars.elementAt(index).starId,
                    'title': popularStars.elementAt(index).starName,
                  },
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(popularStars[index].imageUrl!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(popularStars[index].starName ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: isDark
                                ? CustomTheme.smallTextWhite
                                : CustomTheme.smallText,
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
