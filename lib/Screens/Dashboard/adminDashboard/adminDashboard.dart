import 'package:dairyfarmflow/Functions/customPopUp.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRegistration/animalRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feedEntryPage.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';

class AdminDashboardButtons extends StatefulWidget {
  const AdminDashboardButtons({super.key});

  @override
  State<AdminDashboardButtons> createState() => _AdminDashboardButtons();
}

class _AdminDashboardButtons extends State<AdminDashboardButtons> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(left: 10,top: 20,),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 0,
          crossAxisSpacing: 10,
          mainAxisExtent: 100),
      children: [
        viewContainer("Animal", "lib/assets/cowEntry.png", () async {
          // Navigate to animalRegistrationPage and get the save function
          final Function? saveFunction = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AnimalRegistrationPage(),
            ),
          );
          if (saveFunction != null) {
            // Trigger customPopUp and pass the save function
            customPopUp(context, screenHeight / 3, saveFunction);
          }
        }),
        viewContainer("Wanda", "lib/assets/wanda.png", () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => feedEntryPage()));
        }),
        viewContainer("Worker", "lib/assets/farmWorker.png", () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()));
        }),

        viewContainer("Vendors", "lib/assets/vendorMan.png", () {
          _createVenddorListSheet();
        }),
      ],
    );
  }

  Widget viewContainer(String text, String iconPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(paragraph),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: greyGreenColor,
                          offset: const Offset(2, 2),
                          blurRadius: 6),
                    ]),
                child: Center(
                    child: Image(
                        image: AssetImage(iconPath), width: 35)),
              ),
              Text1(fontColor: lightBlackColor, fontSize: paragraph, text: text),
            ],
          ),
          Positioned(
          bottom: 38,
          right: 15,
          child: Icon(
            CupertinoIcons.plus_circle_fill,
            size: header1 * 1.2,
            color: darkGreenColor,
          ))
        ],
      ),
    );
  }


void _createVenddorListSheet() {
  // Controllers to manage input fields
  final TextEditingController vendorNameController = TextEditingController();
 
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Vendor List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_sharp,size: 30,))
                ],
              ),
              SizedBox(height: 40),
              // Cow ID Field
              TextField(
                controller: vendorNameController,
                //readOnly: true, // Prevent editing Cow ID
                decoration: InputDecoration(
                  labelText: 'Vendor Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              // Breed Type Field
             GestureDetector(
              onTap: (){
                Provider.of<MilkProvider>(context,listen: false).AddVender(context, vendorNameController.text);
                
               Navigator.pop(context);
              },
              child: Container(
               height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Create Vendor"))),
             )
            ],
          ),
        ),
      );
    },
  );
}

}
