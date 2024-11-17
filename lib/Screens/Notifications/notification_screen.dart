import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: darkGreenColor,
        foregroundColor: whiteColor,
        title: Text1(
            fontColor: whiteColor, fontSize: header4, text: "Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  color: whiteColor,
                  child: SizedBox(
                      height: 80,
                      child: ListTile(
                        leading: const CircleAvatar(
                            child: Icon(Icons.notifications)),
                        title: Text1(
                          fontColor: blackColor,
                          fontSize: paragraph,
                          text: "Notifcation Title",
                        ),
                        subtitle: Text1(
                          fontColor: lightBlackColor,
                          fontSize: paragraph,
                          text: "description",
                        ),
                      )),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
