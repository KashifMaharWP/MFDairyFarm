import 'package:dairyfarmflow/Providers/MilkProviders/worker_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Class/textSizing.dart';
import '../../../Functions/customDatePicker.dart';
import '../../../Providers/user_detail.dart';
import '../../../Widget/textFieldWidget1.dart';

class AddWorkerTask extends StatefulWidget {
  String id;
  String name;
   AddWorkerTask({super.key, required this.id, required this.name});

  @override
  State<AddWorkerTask> createState() => _AddWorkerTaskState();
}

class _AddWorkerTaskState extends State<AddWorkerTask> {
  
  DateTime? pickedDate;
  TextEditingController workerName = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    workerName.text=widget.name;
     final token = Provider.of<UserDetail>(context, listen: false).token;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customForm(),
            SizedBox(height: screenHeight*0.03,),
            Consumer<WorkerProvider>(
              builder: (context, value, child) => 
               customRoundedButton(title: "Add Task", loading: value.isLoading, on_Tap: ()async{
                datepiker.text = DateFormat("EEE MMM dd yyyy").format(selectedDate);
               String createdtAt = DateFormat("EEE MMM dd yyyy").format(DateTime.now());
              await Provider.of<WorkerProvider>(context, listen: false).addTask(context, widget.id, taskDescription.text, datepiker.text, createdtAt);
              }),
            )
        
          ],),
      ),
    );
  }
  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Worker Name", CupertinoIcons.person),
            TextFieldWidget1(
              isReadOnly: true,
              widgetcontroller: workerName,
              fieldName: "Worker Name",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            customTextFormField("Date", CupertinoIcons.calendar),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Task", CupertinoIcons.info_circle),
            TextFieldWidget1(
              // keyboardtype: TextInputType.number,
              widgetcontroller: taskDescription,
              fieldName: "Task Description",
              isPasswordField: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(String text, IconData customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(customIcon, color: darkGreenColor),
        Text1(fontColor: blackColor, fontSize: paragraph, text: text),
      ],
    );
  }

  Widget dateContainer() {
    return InkWell(
      onTap: () async {
        pickedDate = await customDatePicker(context, selectedDate);
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate as DateTime;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(paragraph ),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: CupertinoColors.systemGrey3,
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text1(
                fontColor: blackColor,
                fontSize: paragraph+2,
                text: DateFormat("EEE MMM dd yyyy").format(selectedDate)),
            Icon(
              CupertinoIcons.calendar,
              color: darkGreenColor,
            )
          ],
        ),
      ),
    );
  }
}