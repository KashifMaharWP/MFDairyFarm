import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Model/feedInventoryModel.dart';
import 'package:dairyfarmflow/Model/feed_inventory.dart'; // Ensure correct import
import 'package:dairyfarmflow/Providers/InventoryProviders/InventoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedInventoryScreen extends StatefulWidget {
  
  const FeedInventoryScreen({Key? key,}) : super(key: key);

  @override
  _FeedInventoryScreenState createState() => _FeedInventoryScreenState();
}

class _FeedInventoryScreenState extends State<FeedInventoryScreen> {
  FeedInventoryModel? feedInventory;
  bool isLoading = true;

  late DateTime _currentMonth;
  late DateTime _selectedMonth;
  void _goToPreviousMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    });
    _loadFeedInventory(_selectedMonth);
  }

  void _goToNextMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
   _loadFeedInventory(_selectedMonth);
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now(); // Initialize with the current month
    _selectedMonth = _currentMonth;

    _loadFeedInventory(_selectedMonth);

  }

  Future<void> _loadFeedInventory(DateTime selectedMonth) async {
    final fetchedInventory =
        await FeedInventoryProvider.fetchFeedInventory( context, DateFormat('EEE MMM dd yyyy').format(selectedMonth));
    setState(() {
      feedInventory = fetchedInventory;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_sharp),
                color: Colors.white,
                onPressed: () {
                  _goToPreviousMonth(); // Go to the previous month and fetch data
                },
              ),
              Text(
                DateFormat('MMM yyyy').format(_selectedMonth),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_sharp),
                color: Colors.white,
                onPressed: () {
                  if (_selectedMonth.month != _currentMonth.month) {
                    _goToNextMonth();
                  }
                  // Go to the next month and fetch data
                },
              ),
            ],
          ),
        ),
        
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : feedInventory == null
              ? const Center(child: Text("No feed inventory available"))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Feed: ${feedInventory!.totalAmount}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Available Feed: ${feedInventory!.availableAmount}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Date: ${feedInventory!.date}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Feed History",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: feedInventory!.history.length,
                          itemBuilder: (context, index) {
                            final history = feedInventory!.history[index];
                            if(history.action=="+"){
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text("Date: ${history.date}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                       "Feed Entry: ${history.changeAmount}"),
                                  Text(
                                       "Total Feed: ${history.updatedAmount}"),
                                 
                                  ],
                                ),
                              ),
                            );
                            }
                            
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
