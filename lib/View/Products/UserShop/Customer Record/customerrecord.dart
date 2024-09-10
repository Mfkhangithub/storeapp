import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerRecordPage extends StatefulWidget {
  final String shopId; // Pass shopId from UserDashboard

  const CustomerRecordPage({Key? key, required this.shopId}) : super(key: key);

  @override
  _CustomerRecordPageState createState() => _CustomerRecordPageState();
}

class _CustomerRecordPageState extends State<CustomerRecordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemPriceController = TextEditingController();
  TextEditingController _cusNameController = TextEditingController();
  DateTime? _selectedDateTime;
  bool _isCashDone = false;

  void _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
        });
      }
    }
  }

  void _saveCustomerRecord() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance..collection('shops') // Main collection for shops
          .doc(widget.shopId) // Document for the current shop
          .collection('customer_records').add({
          'cusName': _cusNameController.text,
          'itemName': _itemNameController.text,
          'itemPrice': double.parse(_itemPriceController.text),
          'purchaseDateTime': _selectedDateTime != null ? _selectedDateTime!.toIso8601String() : null,
          'paymentStatus': _isCashDone ? 'Cash Done' : 'Cash Remains',
          'shopId': widget.shopId,
          'createdAt': DateTime.now().toIso8601String(),
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Record saved successfully!')));
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving record: $e')));
      }
    }
  }

  void _clearForm() {
    _itemNameController.clear();
    _itemPriceController.clear();
    _cusNameController.clear();
    _selectedDateTime = null;
    _isCashDone = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Record'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _cusNameController,
                decoration: InputDecoration(labelText: "Customer Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter the customer name";
                  return null;
                },
              ),
              TextFormField(
                controller: _itemNameController,
                decoration: InputDecoration(labelText: "Item Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter the item name";
                  return null;
                },
              ),
              TextFormField(
                controller: _itemPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Item Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter the item price";
                  if (double.tryParse(value) == null) return "Please enter a valid price";
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text(_selectedDateTime != null
                  ? "Selected Date & Time: ${DateFormat('dd-MM-yyyy – hh:mm a').format(_selectedDateTime!)}"
                  : "No Date & Time Selected"),
              SizedBox(height: 10),
              ElevatedButton(onPressed: _selectDateTime, child: Text("Select Date & Time")),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isCashDone,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCashDone = value ?? false;
                      });
                    },
                  ),
                  Text("Cash Done"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCustomerRecord,
                child: Text("Save Record"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
