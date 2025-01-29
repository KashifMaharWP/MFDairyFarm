import 'package:dairyfarmflow/Providers/CowProvider/cows_provider.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/add_madicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';
import '../../../Widget/custom_filter_widget.dart';

class AnimalList extends StatefulWidget {
  const AnimalList({super.key});

  @override
  State<AnimalList> createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  @override
  String role = '';

  @override
  Widget build(BuildContext context) {
    // role = Provider.of<UserDetail>(context).role.toString();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            Image.asset(
              "lib/assets/medical.png",
              width: 30,
              
            ),
            const Text("Medical Record"),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * .015,
          ),
          role == "Admin"
              ? Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * .07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: customFiltersWidget()),
                )
              : const Center(),
          SizedBox(
            height: screenHeight * .015,
          ),
          const CowsList(),
        ],
      ),
    );
  }
}

class CowsList extends StatefulWidget {
  const CowsList({
    super.key,
  });

  @override
  State<CowsList> createState() => _CowsListState();
}
class _CowsListState extends State<CowsList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CowsProvider>(context,listen: false).fetchCows(context);
  });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CowsProvider>(
        
        builder: (context,cowProvider ,child) {
         // cowProvider.fetchCows(context);
          if (cowProvider.isCowListLoad) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }  else {
            final cows = cowProvider.cowList?.cows??[];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 2, // Spacing between rows
                  childAspectRatio:
                      screenWidth / (screenHeight / 1.8), // Adjust as needed
                ),
                itemCount: cows.length,
                itemBuilder: (BuildContext context, int index) {
                  final cow = cows[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMedicine(id: cow.id),
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth + 10,
                      height: screenHeight + 10,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(paragraph),
                        boxShadow: [
                          BoxShadow(
                            color: greyGreenColor,
                            blurRadius: 6,
                            spreadRadius: 3,
                            offset: const Offset(2, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: screenHeight * .20,
                                  width: screenWidth * .58,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        cow.image,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                              ),
                              // role == "Admin"
                              //     ? InkWell(
                              //         onTap: () {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       feedEntryPage(
                              //                         id: cow.id,
                              //                       )));
                              //         },
                              //         child: Icon(
                              //           Icons.more_vert,
                              //           color: darkGreenColor,
                              //           size: screenWidth * .070,
                              //         ),
                              //       )
                              //     : const Center(),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.tag_fill,
                                    color: darkGreenColor,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: screenWidth * .007,
                                  ),
                                  Text1(
                                    fontColor: lightBlackColor,
                                    fontSize: screenWidth * .04,
                                    text: "Animal ${cow.animalNumber}",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "lib/assets/cowbreed.png",
                                    width: screenWidth * .060,
                                    height: screenWidth * .060,
                                  ),
                                  SizedBox(
                                    width: screenWidth * .007,
                                  ),
                                  Text1(
                                    fontColor: lightBlackColor,
                                    fontSize: screenWidth * .04,
                                    text: cow.breed,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.money_dollar_circle_fill,
                                    color: darkGreenColor,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: screenWidth * .007,
                                  ),
                                  Text1(
                                    fontColor: lightBlackColor,
                                    fontSize: screenWidth * .04,
                                    text: cow.age
                                        .toString(), // Update as needed
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}


