import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerRecordListPage extends StatelessWidget {
  final String shopId;

  const CustomerRecordListPage({Key? key, required this.shopId}) : super(key: key);

  Stream<QuerySnapshot> _fetchCustomerRecords() {
  // Fetch records from the customer_records subcollection under the specific shopId
  return FirebaseFirestore.instance
      .collection('shops')
      .doc(shopId) // Access the specific shop
      .collection('customer_records') // Access the customer_records subcollection
      .orderBy('createdAt', descending: true) // You can order by date if needed
      .snapshots();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Records'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchCustomerRecords(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final records = snapshot.data!.docs;

            if (records.isEmpty) {
              return Center(child: Text('No customer records found.'));
            }

            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                final cusName = record['cusName'];
                final itemName = record['itemName'];
                final itemPrice = record['itemPrice'];
                final purchaseDateTime = record['purchaseDateTime'] != null
                    ? DateFormat('dd-MM-yyyy – hh:mm a').format(DateTime.parse(record['purchaseDateTime']))
                    : 'No date';
                final paymentStatus = record['paymentStatus'];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cusName, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(itemName, style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: \$${itemPrice.toStringAsFixed(2)}'),
                        Text('Date & Time: $purchaseDateTime'),
                        Text('Payment Status: $paymentStatus'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
