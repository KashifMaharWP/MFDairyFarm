import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/Worker/user_task_model.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/worker_provider.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //String userId ='';

  @override
  Widget build(BuildContext context) {
    final userId =
        Provider.of<UserDetail>(context).id.toString();

    final taskProvider = Provider.of<WorkerProvider>(context);
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
                child: FutureBuilder<UserTaskModel?>(
                    future: taskProvider.fetchTaskById(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('An error occurred: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data != null) {
                         final tasks = snapshot.data!.tasks ?? [];
                        return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final usertask = tasks[index];
                            return Card(
                              elevation: 3,
                              color: whiteColor,
                              child: SizedBox(
                                  height: 80,
                                  child: ListTile(
                                    onTap: () async{
                                      print(usertask.sId.toString());
                                    await taskProvider.upadateTask(context, usertask.sId.toString());
                                    },
                                    leading: const CircleAvatar(
                                        child: Icon(Icons.notifications)),
                                    title: Text1(
                                      fontColor: blackColor,
                                      fontSize: paragraph,
                                      text: usertask.description.toString(),
                                    ),
                                    subtitle: Text1(
                                      fontColor: lightBlackColor,
                                      fontSize: paragraph,
                                      text:  usertask.taskStatus.toString(),
                                    ),
                                  )),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
