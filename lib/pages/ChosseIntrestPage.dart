import 'package:flutter/material.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/pages/chooseAccount.dart';

class ChooseInterest extends StatefulWidget {
  const ChooseInterest({super.key});

  @override
  State<ChooseInterest> createState() => _ChooseInterestState();
}

class _ChooseInterestState extends State<ChooseInterest> {
  List listOfIntrest = [
    "Action",
    "Horror",
    "Adveture",
    "Drama",
    "War",
    "Crime",
    "Romance",
    "History",
    "Music",
    "Comedy",
    "Anime",
    "Television",
    "Thriller"
  ];

  List listOfIntrestBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  String? selectedIntrest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 37, 37).withOpacity(0.9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Choose your interest here and get the best movie recommandations. Don't worry you can always change it later.",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),

              GridView.builder(
                shrinkWrap: true,
                itemCount: listOfIntrest.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // childAspectRatio: 1.3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      var ind = listOfIntrestBool
                          .indexWhere((element) => element == true);

                      // if (ind != -1) {
                      //   listOfIntrestBool[ind] = false;
                      // }

                      listOfIntrestBool[index] =
                          listOfIntrestBool[index] ? false : true;
                      setState(() {});
                    },
                    child: Container(
                        // height: 10,
                        // width: 10,
                        decoration: BoxDecoration(
                            color: listOfIntrestBool[index]
                                ? Colors.purple.withOpacity(0.3)
                                : Color.fromARGB(255, 41, 37, 37)
                                    .withOpacity(0.9),
                            borderRadius: BorderRadius.circular(120),
                            border: Border.all(
                                color: listOfIntrestBool[index]
                                    ? Colors.purple
                                    : Colors.black,
                                width: 4)),
                        child: Center(
                            child: Text(
                          listOfIntrest[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ))),
                  );
                },
              )

              // Wrap(
              //     direction: Axis.horizontal,
              //     children: listOfIntrest
              //         .map(
              //           (e) => Padding(
              //             padding: const EdgeInsets.only(right: 10, bottom: 10),
              //             child: GestureDetector(
              //                 onTap: () {
              //                   selectedIntrest = e;
              //                   setState(() {});
              //                   //  print("data ${e.documentkey}");
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Text(
              //                       e,
              //                       style: TextStyle(
              //                           fontSize: 23,
              //                           color: selectedIntrest == e
              //                               ? Colors.black
              //                               : Colors.amberAccent),
              //                     ),
              //                   ],
              //                 )
              //                 //  radiusButton(e.documenttext!, e.documentkey! )

              //                 ),
              //           ),
              //         )
              //         .toList())
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        // width: 100,
        padding: EdgeInsets.symmetric(horizontal: 17),
        height: 130,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ChooseAccount();
                  },
                ));
                // Get.to(LoginInput(type: "Sign Up"));
              },
              child: PrimaryButton(
                title: "CONTINUE",
                width: double.infinity,
                height: 69,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "SKIP",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              style: TextButton.styleFrom(),
            )
          ],
        ),
      ),
    );
  }
}
