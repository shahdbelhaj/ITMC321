import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Bytes/main.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _selectedPaymentMethod = 'credit_card';

  void _showSnackbarAndNavigate(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false,
      );
    });
  }

  bool _isCreditCardValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الدفع',
          style: GoogleFonts.almarai(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أدخل تفاصيل الدفع',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 38, 66),
                fontFamily: GoogleFonts.almarai().fontFamily,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('بطاقة ائتمان'),
                    leading: Radio<String>(
                      value: 'credit_card',
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('بطاقة مصرفية'),
                    leading: Radio<String>(
                      value: 'paypal',
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_selectedPaymentMethod == 'credit_card') ...[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: InputDecoration(
                        labelText: 'رقم البطاقة الائتمانية',
                        labelStyle: TextStyle(
                          fontFamily: GoogleFonts.almarai().fontFamily,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم البطاقة';
                        }
                        if (value.length != 16) {
                          return 'يجب أن يحتوي رقم البطاقة على 16 رقمًا';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _expiryDateController,
                      decoration: InputDecoration(
                        labelText: 'تاريخ انتهاء الصلاحية',
                        labelStyle: TextStyle(
                          fontFamily: GoogleFonts.almarai().fontFamily,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال تاريخ انتهاء الصلاحية';
                        }
                        if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$')
                            .hasMatch(value)) {
                          return 'الرجاء إدخال تاريخ صالح (MM/YY)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _cvvController,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        labelStyle: TextStyle(
                          fontFamily: GoogleFonts.almarai().fontFamily,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال CVV';
                        }
                        if (value.length != 3) {
                          return 'يجب أن يحتوي CVV على 3 أرقام';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod == 'credit_card' &&
                    _isCreditCardValid()) {
                  _showSnackbarAndNavigate(context, 'تم الدفع بنجاح');
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 2, 61, 107),
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: GoogleFonts.almarai().fontFamily,
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('إتمام الدفع'),
            ),
          ],
        ),
      ),
    );
  }
}
