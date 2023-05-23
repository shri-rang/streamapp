import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/screen/landing_screen.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({super.key});

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  List whosWatching = ["Prabhat", "Rahul", "Vivek", "Sanket"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 37, 37).withOpacity(0.9),
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Text("Who's Watching?",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            Text("Choose an account",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: whosWatching.length,
              itemBuilder: (context, index) {
                return InkWell(
                  
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LandingScreen();
                      },
                    ));
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Image.asset(
                          "assets/profile2.jpg",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        child: Text(
                          whosWatching[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Container(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 41, 37, 37).withOpacity(0.9),
            //       border: Border.all(color: Colors.black)),
            // child:
            Container(
                width: 100,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: orange),
                child:
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.pink,

                    //         side: BorderSide(

                    //         ) ),
                    //     onPressed: () {},
                    //     child:
                    Center(
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Edit",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ))

                //     // ),
                // ),
                )
          ],
        ),
      ),
    );
  }
}
