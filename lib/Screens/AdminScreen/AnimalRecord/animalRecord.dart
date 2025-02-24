import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Widget/animali_record_widget.dart';

class AnimalRecord extends StatefulWidget {
  const AnimalRecord({super.key});

  @override
  State<AnimalRecord> createState() => _AnimalRecordState();
}

class _AnimalRecordState extends State<AnimalRecord> {
  @override
  String role = '';

  @override
  Widget build(BuildContext context) {
    role = Provider.of<UserDetail>(context).role.toString();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: role == "Admin"
            ? const Text("Animal Record")
            : const Text("Add Milk"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * .015,
          ),
          // role == "Admin"
          //     ? Container(
          //         width: screenWidth * 0.95,
          //         height: screenHeight * .07,
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(10)),
          //         child: const Center(child: AnimalFilterWidget()),
          //       )
          //     : const Center(),
          // SizedBox(
          //   height: screenHeight * .015,
          // ),
          
          AnimalRecordWidget(role: role),
        ],
      ),
    );
  }
}



// Future<CowsResponse?> fetchCows(BuildContext context) async {
  
//   var headers = {
//     'Authorization':
//         'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
//   };
//   var request = http.Request(
//     'GET',
//     Uri.parse('${GlobalApi.baseApi}${GlobalApi.getAnimal}'),
//   );

//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   if (response.statusCode == 200) {
//     final jsonString = await response.stream.bytesToString();
//     final jsonData = json.decode(jsonString);
//     return CowsResponse.fromJson(jsonData);
//   } else {
//     if (kDebugMode) {
//       print("Error: ${response.reasonPhrase}");
//     }
//     return null;
//   }
// }
