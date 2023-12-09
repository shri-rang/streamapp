import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/screen/Tabs/Buy.dart';
import 'package:oxoo/screen/Tabs/Sell.dart';
import 'package:oxoo/server/repository.dart';
import 'package:oxoo/widgets/home_screen/country_item.dart';
import 'package:oxoo/widgets/home_screen/popular_star.dart';
import 'package:provider/provider.dart';
import '../../models/configuration.dart';
import '../../models/home_content.dart';
import '../../widgets/banner_ads.dart';
import '../models/user_model.dart';
import '../service/authentication_service.dart';
import '../service/get_config_service.dart';
import '../style/theme.dart';
import '../utils/loadingIndicator.dart';
import '../widgets/home_screen/features_genre_movies_item.dart';
import '../widgets/home_screen/genre_item.dart';
import '../widgets/home_screen/live_tv_item.dart';
import '../widgets/home_screen/movie_item.dart';
import '../widgets/home_screen/slider.dart';
import '../widgets/home_screen/tv_series_item.dart';
import '../strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var appModeBox = Hive.box('appModeBox');
  bool? isDark;
  late Future<HomeContent> _homeContent;
  TabController? _controller; 
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
    _homeContent = Repository().getHomeContent();
    _controller = TabController(length: 2, vsync: this); 
      _controller!.addListener(() {
    setState(() {
      _selectedIndex = _controller!.index;
    });
    print("Selected Index: " + _controller!.index.toString());
  });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final configService = Provider.of<GetConfigService>(context);

    AuthUser? authUser = authService.getUser();
    PaymentConfig? paymentConfig = configService.paymentConfig();
    AppConfig? appConfig = configService.appConfig();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor:
              isDark! ? CustomTheme.primaryColorDark : Colors.transparent,
          automaticallyImplyLeading: false,
          title: Image.asset("assets/logo.png",
           width: 100,
           height: 100,
          ),
         // bottom: TabBar(
          //   indicatorColor: purple,
          //   tabs: [
          //     Tab(
          //         icon: Text("Buy",
          //             style: TextStyle(
          //                 fontFamily: 'Sans Serif',
          //                 fontSize: 15.sp,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold))) ,
          //     Tab(
          //         icon: Text("Sell",
          //             style: TextStyle(
          //                 fontFamily: 'Sans Serif',
          //                 fontSize: 15.sp,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold))),
          //     // Tab(icon: Icon(Icons.directions_car)),
          //   ],
          // ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: PrimaryButton(
                title: "SIGN UP",
                width: 110,
                onTap: () {},
                // screenWidth * .8,
                height: 40,
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
            //   child: PrimaryButton(
            //     title: "LOGIN",
            //     width: 80,
            //     onTap: () {},
            //     // screenWidth * .8,
            //     height: 25,
            //   ),
            // ),
          ],
        ),
        backgroundColor:
         //   isDark! ?

            CustomTheme.primaryColorDark,

                ///: Colors.transparent,
        body:
           SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.symmetric( horizontal: 16, vertical:  16 ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    // Text("Hello, Shrirang",
                    //  style:  TextStyle( fontSize: 18),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                   // header(),

                   CarouselSlider(
  options: CarouselOptions(
    aspectRatio: 2,
    viewportFraction: 1.01
    // height: 200.0
    
    ),
  items: ["assets/poster.jpg", "assets/poster1.jpg"].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          // decoration: BoxDecoration(
          //   color: Colors.amber
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(i,
            fit:BoxFit.fill ,
            ),
          )
        );
      },
    );
  }).toList(),
),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 450,
                      
                      decoration: BoxDecoration(
                        color: purple,
                         borderRadius: BorderRadius.circular(8)
             
                      ),
                      child: Column(
                        children: [
                             TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,

                                 unselectedLabelStyle:  TextStyle( 
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ) ,
                            
                              controller: _controller,
                                           indicator: BoxDecoration(
             
                 // borderRadius: BorderRadius.circular(50), // Creates border
                 color: Color(0xff212121) ,),

                             indicatorWeight: 2,
             
                               indicatorColor: Colors.black,
                              labelColor: purple,
                              labelStyle:  TextStyle( 
                                
                                 color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              dividerColor: purple,
                              tabs: [
                                Tab(icon:  Text("Buy", style:   TextStyle( 
                               
                              ) ,
                                )
                                ),
                                 Tab(icon:
                                  Text("Sell",
                              //     style:   TextStyle( 
                              //   color: Colors.white54
                              // ) ,
                                 )   ),
                             ]),
                              Container(
                                height: 400,
                                child: TabBarView(
                                  controller: _controller,
                                  children: [
                                          buy(),
                                          sell()
                                ] ),
                              ),
                        ],
                      ),
                    )
                 ],
               ),
             ),
           )
        // TabBarView(
        //   children: [
        //     BuyScreen(),
        //     SellScreen()
        //     // Icon(Icons.directions_car, size: 350),
        //   ],
        // ),
        // FutureBuilder<HomeContent>(
        //   future: _homeContent,
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       return buildUI(
        //           context: context,
        //           authUser: authUser,
        //           paymentConfig: paymentConfig,
        //           appConfig: appConfig,
        //           homeContent: snapshot.data);
        //     } else if (snapshot.hasError) {
        //       return Center(
        //         child: Text(
        //           AppContent.somethingWentWrong,
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       );
        //     }

        //     return Center(
        //       child: spinkit,
        //     );
        //   },
        // ),
        // body: BlocBuilder<HomeContentBloc, HomeContentState>(
        //   builder: (context, state) {
        //     if (state is HomeContentLoadingState) {
        //       BlocProvider.of<HomeContentBloc>(context)..add(FetchHomeContentData());
        //     } else if (state is HomeContentErrorState) {
        //       return Center(
        //         child: Text(AppContent.somethingWentWrong),
        //       );
        //     } else if (state is HomeContentLoadedState) {
        //       printLog("--------home content data loaded");

        //       return buildUI(context: context, authUser: authUser, paymentConfig: paymentConfig, homeContent: state.homeContent);
        //     }
        //     return Center(child: spinkit);
        //   },
        // ),
      ),
    );
  }

 int? selectedVal;
 
 Widget buy(){
   return Padding(
     padding: const EdgeInsets.all(16.0),
     child: Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
         color: purple,
      ),
          
         child: Column(
          children: [
             Container(
              height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
         color: Color(0xff212121),
      ),
              child: 
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   colunm("Gold Price", "₹ 6356.40 /gm "),
                 
                     colunm("Purity", "24 K /999 "),
                  ],

                ),
              ),
             ),

             SizedBox(
              height: 20,
             ),
             Container(height: 248,
                   decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
         color: Color(0xff212121),
      ),
              child: Column(children: [
                SizedBox(
              height: 20,
             ),
                      Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  select("Buy in Rupees", 1),
            select("Buy in Gram", 2)
              ],
             ),
               SizedBox(
              height: 20,
             ),
           Padding(
             padding: const EdgeInsets.symmetric( horizontal: 16),
             child: TextFormField(
              decoration: InputDecoration(
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.7),
                   )
                 ),
                 focusedBorder: 
                 OutlineInputBorder(
                   borderSide: BorderSide(
                    color: purple
                   )
                 ),
                border: OutlineInputBorder(
                borderSide: BorderSide(

                )
                )
              ),
             ),
           ),
            SizedBox(
              height: 20,
             ),
            PrimaryButton(
                title: "BUY",
                width: 110,
                onTap: () {},
                // screenWidth * .8,
                height: 40,
              ),
              ]),
             ),
           
            

          ],
         ),
     ),
   );

 }


 Widget colunm(String title , subtitle ){
    return   Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                            height: 25,
                           ),
                          Text(title,
                            style: TextStyle(
                              color: Colors.white60,
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                            ),
                          ),
                           SizedBox(
                            height: 10,
                           ),
                            Text(subtitle,
                                style:  TextStyle(
                                    fontSize: 16,
                                   // fontWeight: FontWeight.bold,
                                   color: Colors.white.withOpacity(0.7)
                                ),
                              )
                        ],
                      ),
                    );

 }

 
 Widget select(String title, int val ){

     return  Row(
              children: [
                 
                 Radio(
                  activeColor: Colors.white.withOpacity(0.7),
                  value: val, groupValue: selectedVal, onChanged: (v){
                 selectedVal  = v ;
                 setState(() {
                   
                 });
                 }),

                 Text(title,
                  style:   TextStyle(color: Colors.white.withOpacity(0.7), ),
                 )

              ],
            );

 }
 Widget sell(){
   return Padding(
     padding: const EdgeInsets.all(16.0),
     child: Container(
      height: 300,
                  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
           color: Color(0xff212121),
        ),
        child:  Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Create an account to buy and sell",
              style:  TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
             SizedBox(
              height: 10,
             ),
             Center(
              child: Text("24 k gold",
              style:  TextStyle(
                color: Colors.white.withOpacity(0.7),
                  fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
          ],
        ),
     ),
   );

 }

  Widget header(){

    return   Container(
                     width: double.infinity,
                     height: 150,
                     decoration: BoxDecoration(
                         color: purple,
                      border: Border.all(
                        color: purple
                      ),
                      borderRadius: BorderRadius.circular(8),
                     
                    ),
                    child: Row(
                      children: [
                         ClipRRect(
                            borderRadius: BorderRadius.only( topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                           child: Image.asset('assets/gold.jpeg',
                            width: 170,
                             height: 150,
                             fit: BoxFit.fill,
                           ),

                         ),
                          SizedBox(
                            width: 15,
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 22,
                            ),
                             Text("GOLD Price",
                              style:  TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)
                              ),
                             ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("24k/999",
                              style:  TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7)
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("₹ 6356.40 /gm ",
                              style:  TextStyle(
                                  fontSize: 24,
                                 // fontWeight: FontWeight.bold,
                                 color: Colors.black.withOpacity(0.7)
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
  }




  Widget buildUI(
      {BuildContext? context,
      PaymentConfig? paymentConfig,
      AuthUser? authUser,
      AppConfig? appConfig,
      required HomeContent homeContent}) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 5),
            child: ImageSlider(homeContent.slider),
          ),
        ),
        SliverToBoxAdapter(
          child: BannerAds(
            isDark: isDark,
          ),
        ),

        //country
        if (appConfig!.countryVisible)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: HomeScreenCountryList(
                  countryList: homeContent.allCountry, isDark: isDark!),
            ),
          ),

        //genre
        // if (appConfig.genreVisible)
        //   SliverToBoxAdapter(
        //     child: Container(
        //       margin: EdgeInsets.only(top: 5, bottom: 5),
        //       child: HomeScreenGenreList(
        //         genreList: homeContent.allGenre,
        //         isDark: isDark,
        //       ),
        //     ),
        //   ),
        //Featured TV Channels
        // if (homeContent.featuredTvChannel!.isNotEmpty)
        //   SliverToBoxAdapter(
        //     child: Container(
        //       margin: EdgeInsets.only(top: 5, bottom: 5),
        //       child: HomeScreenLiveTVList(
        //           tvList: homeContent.featuredTvChannel,
        //           title: AppContent.featuredTvChannels,
        //           isSearchWidget: false,
        //           isDark: isDark,
        //           isFromHomeScreen: true),
        //     ),
        //   ),
        //popular star
        // if (homeContent.popularStars!.isNotEmpty)
        //   SliverToBoxAdapter(
        //     child: Container(
        //       margin: EdgeInsets.only(top: 2, bottom: 5, left: 8),
        //       child: PopularStarWidget(
        //         isDark: isDark!,
        //         popularStars: homeContent.popularStars!,
        //       ),
        //     ),
        //   ),

        //Latest movies
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 2, bottom: 15),
            child: HomeScreenMovieList(
              latestMovies: homeContent.latestMovies,
              context: context,
              title: AppContent.latestMovies,
              isDark: isDark,
            ),
          ),
        ),
        //latest tv series
        // if (homeContent.latestTvseries!.isNotEmpty)
        //   SliverToBoxAdapter(
        //     child: Container(
        //       margin: EdgeInsets.only(top: 2, bottom: 15),
        //       child: HomeScreenSeriesList(
        //         latestTvSeries: homeContent.latestTvseries,
        //         title: AppContent.latestTvSeries,
        //         // context: context,
        //         // authUser: authUser,
        //         isDark: isDark,
        //       ),
        //     ),
        //   ),
        // HomeScreenGenreMoviesList(
        //   genreMoviesList: homeContent.featuresGenreAndMovie,
        //   isDark: isDark,
        // ),
      ],
    );
  }
}
