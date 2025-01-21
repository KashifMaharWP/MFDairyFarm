import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorList extends StatefulWidget {
  const VendorList({super.key});

  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    Provider.of<MilkProvider>(context,listen: false).fetchVendors(context);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Vendor List"),
        backgroundColor: Colors.white,
      ),
      body: Consumer<MilkProvider>(
        builder: (context,provider,child) {
          if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
      
            final vendors = provider.vendors;
            if (vendors.isEmpty) {
              return const Center(child: Text('No vendors available'));
            }
      
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  final vendor = vendors[index];
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                              backgroundColor: Colors.black87,
                              backgroundImage: AssetImage("lib/assets/vendorMan.png"),
                          ),
                          SizedBox(width: 10,),
                          Text(vendor.name,style: TextStyle(
                            fontSize: 16
                          ),),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
        }
      ),
    );
  }
}