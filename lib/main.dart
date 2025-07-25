import 'package:flutter/material.dart';

void main() {
  runApp(SendMoneyApp());
}

class SendMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: LoginPage(),
    );
  }
}

// --------------------- Login Page ---------------------
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DashboardPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final offsetAnimation = Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ));
          },
        ),
      ),
    );
  }
}

// --------------------- Dashboard Page ---------------------
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
        child: ElevatedButton(
          child: Text('Send Money'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SendMoneyPage()),
            );
          },
        ),
      ),
    );
  }
}

// --------------------- Send Money Page ---------------------
class SendMoneyPage extends StatefulWidget {
  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _paymentMethod = 'Bank Transfer';
  bool _isFavorite = false;
  bool _showSuccess = false;

  final List<String> _methods = [
    'Bank Transfer',
    'Mobile Money',
    'Credit Card'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showSuccess = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _showSuccess = false);
      });
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Money")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// Recipient Name
              TextFormField(
                controller: _recipientController,
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
              ),
              SizedBox(height: 16),

              /// Amount
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  final num? amount = num.tryParse(value ?? '');
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              /// Payment Method
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: InputDecoration(labelText: 'Payment Method'),
                items: _methods
                    .map((method) =>
                        DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              SizedBox(height: 16),

              /// Favorite Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mark as Favorite'),
                  Switch(
                    value: _isFavorite,
                    onChanged: (val) => setState(() => _isFavorite = val),
                  ),
                ],
              ),
              SizedBox(height: 24),

              /// Reusable Button
              SendMoneyButton(onPressed: _submitForm),
              SizedBox(height: 24),

              /// Success Message Animation
              AnimatedOpacity(
                opacity: _showSuccess ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text("Transaction Successful!",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------- Custom Reusable Button ---------------------
class SendMoneyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendMoneyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.send),
      label: Text("Send Money"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(fontSize: 16),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
