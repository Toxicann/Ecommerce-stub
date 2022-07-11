import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../Provider/cart.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController deliveryAddressController =
      TextEditingController();

  final TextEditingController billingAddressController =
      TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2060));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                const Text('Fill the form to checkout your items.'),
                FormTextInput(
                  controller: nameController,
                  labelText: 'Name',
                  keyboardType: TextInputType.name,
                  maxLength: 25,
                ),
                FormTextInput(
                  controller: phoneController,
                  labelText: 'Phone No.',
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
                FormTextInput(
                  controller: billingAddressController,
                  labelText: 'Billing Address',
                  keyboardType: TextInputType.streetAddress,
                  maxLength: 50,
                ),
                FormTextInput(
                  controller: deliveryAddressController,
                  labelText: 'Delivery Address',
                  keyboardType: TextInputType.streetAddress,
                  maxLength: 50,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    'Picked Date: ${DateFormat('d-MMM-yyyy').format(selectedDate)}',
                  ),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    // ignore: avoid_print
                    print({
                      'Name': nameController.text,
                      'Phone': phoneController.text,
                      'Billign Address': billingAddressController.text,
                      'Delivery Address': deliveryAddressController.text,
                      'Items Bought': inspect(cart.cartList),
                      'Total Price': cart.totalSum,
                    });
                    nameController.clear();
                    phoneController.clear();
                    billingAddressController.clear();
                    deliveryAddressController.clear();
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormTextInput extends StatelessWidget {
  const FormTextInput({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          label: Text(labelText),
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          contentPadding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
