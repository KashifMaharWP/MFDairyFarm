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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<WorkerProvider>(context, listen: false)
          .fetchAllTasks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserDetail>(context).id.toString();

    final taskProvider = Provider.of<WorkerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: darkGreenColor,
        foregroundColor: whiteColor,
        title: Text1(
            fontColor: whiteColor, fontSize: header1, text: "Today Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: Consumer<WorkerProvider>(
              builder: (context, workerProvider, child) {
                final tasks = workerProvider.TaskList?.tasks;

                if (workerProvider.isTaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (tasks != null && tasks.isNotEmpty) {
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final usertask = tasks[index];
                      // Create a ValueNotifier for each task's checkbox state
                      final checkboxValueNotifier = ValueNotifier<bool>(
                        usertask.taskStatus ?? false,
                      );

                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        //padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: ListTile(
                          leading: ValueListenableBuilder<bool>(
                            valueListenable: checkboxValueNotifier,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                checkColor: Colors.white,
                                activeColor: darkGreenColor,
                                onChanged: (bool? newValue) async {
                                  if (newValue != null) {
                                    // Update the UI immediately
                                    checkboxValueNotifier.value = newValue;

                                    // Call the updateTask function
                                    workerProvider.updateTask(
                                      context,
                                      usertask.sId.toString(),
                                    );

                                    // Optionally, refetch the updated task or manage the state accordingly
                                    checkboxValueNotifier.value = workerProvider
                                            .TaskList
                                            ?.tasks?[index]
                                            .taskStatus ??
                                        false;
                                  }
                                },
                              );
                            },
                          ),
                          title: Text1(
                            fontColor: blackColor,
                            fontSize: header1,
                            text: usertask.description.toString(),
                          ),
                          // subtitle:Icon(usertask.taskStatus.toString()=='true'?Icons.check:Icons.close) ,
                          // // Text1(
                          // //   fontColor: lightBlackColor,
                          // //   fontSize: header5,
                          // //   text: usertask.taskStatus.toString(),
                          // // ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Task Description'),
                                content: Text(usertask.description ??
                                    'No Description Available'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
