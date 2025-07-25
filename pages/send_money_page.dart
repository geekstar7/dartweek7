import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/animated_success_message.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String? _recipient;
  double? _amount;
  String _method = 'M-Pesa';
  bool _isFavorite = false;
  bool _showSuccess = false;

  final _methods = ['M-Pesa', 'Bank', 'PayPal'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _showSuccess = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_showSuccess) const AnimatedSuccessMessage(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Recipient Name'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                    onSaved: (value) => _recipient = value,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    validator: (value) {
                      final number = double.tryParse(value ?? '');
                      if (number == null || number <= 0) {
                        return 'Enter a positive amount';
                      }
                      return null;
                    },
                    onSaved: (value) => _amount = double.tryParse(value!),
                  ),
                  DropdownButtonFormField(
                    value: _method,
                    items: _methods.map((method) {
                      return DropdownMenuItem(
                          value: method, child: Text(method));
                    }).toList(),
                    onChanged: (value) => setState(() => _method = value!),
                  ),
                  SwitchListTile(
                    title: const Text('Mark as Favorite'),
                    value: _isFavorite,
                    onChanged: (value) => setState(() => _isFavorite = value),
                  ),
                  CustomButton(
                      label: 'Send Money',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _submitForm();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
