import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Providers/CowProvider/cows_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/colorPallete.dart';
import '../Class/screenMediaQuery.dart';
import '../Screens/AdminScreen/AnimalRecord/animal_detail.dart';
import '../Screens/AdminScreen/MilkRecordScreen/add_evening_milk.dart';
import '../Screens/AdminScreen/MilkRecordScreen/add_morning_milk.dart';

class AnimalRecordWidget extends StatefulWidget {
  const AnimalRecordWidget({
    super.key,
    required this.role,
  });

  final String role;

  @override
  State<AnimalRecordWidget> createState() => _AnimalRecordWidgetState();
}

class _AnimalRecordWidgetState extends State<AnimalRecordWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CowsProvider>(context, listen: false).fetchCows(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CowsProvider>(
      builder: (context, cowsProvider, child) {
        if (cowsProvider.isCowListLoad) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final cows = cowsProvider.cowList?.cows ?? [];
          return Flexible(
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
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onLongPress: widget.role == "Admin"
                        ? () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Choose an action'),
                                  actions: <Widget>[
                                    // Update action
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog first
                                        //_showUpdateCowSheet(cow.id,cow.breed); // Call the function with parentheses
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.edit,
                                              color: Colors.blue), // Edit icon
                                          SizedBox(width: 8),
                                          Text('Update',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                        ],
                                      ),
                                    ),
                                    // Delete action
                                    TextButton(
                                      onPressed: () async {
                                        // Call the deleteCow method from CowsProvider
                                        await Provider.of<CowsProvider>(context,
                                                listen: false)
                                            .deleteCow(context, cow.id);

                                        // Close the dialog after deletion
                                        Navigator.of(context).pop();
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.delete,
                                              color: Colors.red), // Delete icon
                                          SizedBox(width: 8),
                                          Text('Delete',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                    onTap: widget.role == "Admin"
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnimalDetail(
                                          tag: cow.animalNumber.toString(),
                                          url: cow.image,
                                          id: cow.id,
                                        )));
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddMorningMilk(
                                                        id: cow.id,
                                                      )));
                                        },
                                        leading: Image(
                                          image: const AssetImage(
                                              "lib/assets/sun.png"),
                                          width: screenWidth * .075,
                                          height: screenWidth * .075,
                                        ),
                                        title: const Text("Morning"),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEveningMilk(
                                                          id: cow.id)));
                                        },
                                        leading: Image(
                                          image: const AssetImage(
                                              "lib/assets/moon.png"),
                                          width: screenWidth * .075,
                                          height: screenWidth * .075,
                                        ),
                                        title: const Text("Evening"),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                    child: Container(
                      width: screenWidth + 10,
                      height: screenHeight + 10,
                      padding: const EdgeInsets.all(5),
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
                              Container(
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
                              
                            ],
                          ),
                          const SizedBox(
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
                              const SizedBox(
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
                              const SizedBox(
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
                                    text:
                                        cow.age.toString(), // Update as needed
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  void _showUpdateCowSheet(String cowId, String breedType) {
    // Controllers to manage input fields
    final TextEditingController cowIdController =
        TextEditingController(text: cowId);
    final TextEditingController breedTypeController =
        TextEditingController(text: breedType);
    //final TextEditingController priceController = TextEditingController(text: price.toString());

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Cow Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Cow ID Field
              TextField(
                controller: cowIdController,
                readOnly: true, // Prevent editing Cow ID
                decoration: InputDecoration(
                  labelText: 'Cow ID',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              // Breed Type Field
              TextField(
                controller: breedTypeController,
                decoration: const InputDecoration(
                  labelText: 'Breed Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Price Field

              const SizedBox(height: 16),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Perform update logic
                    final updatedCowId = cowIdController.text;
                    final updatedBreedType = breedTypeController.text;
                    // final updatedPrice = double.tryParse(priceController.text) ?? price;

                    // Call provider or API to update cow details
                    // Provider.of<CowsProvider>(context, listen: false).updateCow(
                    //   context: context,
                    //   cowId: updatedCowId,
                    //   breedType: updatedBreedType,
                    //   price: updatedPrice,
                    // );

                    // Close the bottom sheet after saving
                    Navigator.pop(context);
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
