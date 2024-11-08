import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Bytes/pages/payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Raspberry Pi 4',
      'quantity': 1,
      'price': 150.0,
      'image': 'assets/images/raspberry_pi_4.jpg'
    },
    {
      'name': 'Arduino Uno',
      'quantity': 3,
      'price': 50.0,
      'image': 'assets/images/arduino_uno_1.png'
    },
  ];

  double get totalAmount => cartItems.fold(
        0.0,
        (previousValue, item) =>
            previousValue +
            (item['quantity'] as int) * (item['price'] as double),
      );

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _removeItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحذف'),
          content: Text('هل أنت متأكد أنك تريد إزالة هذا المنتج من العربة؟'),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                setState(() {
                  cartItems.removeAt(index);
                });
                Navigator.of(context).pop();
                _showSnackbar(context, 'تمت إزالة المنتج من العربة');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عربة التسوق',
          style: GoogleFonts.almarai(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            item['image'] as String,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 2, 38, 66),
                                    fontFamily:
                                        GoogleFonts.almarai().fontFamily,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'الكمية: ${item['quantity']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 2, 38, 66),
                                    fontFamily:
                                        GoogleFonts.almarai().fontFamily,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'السعر: ${(item['quantity'] as int) * (item['price'] as double)} د.ل',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 2, 38, 66),
                                    fontFamily:
                                        GoogleFonts.almarai().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 32.0, color: Color.fromARGB(255, 2, 61, 107)),
            Text(
              'الإجمالي: ${totalAmount.toStringAsFixed(2)} د.ل',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 38, 66),
                fontFamily: GoogleFonts.almarai().fontFamily,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                );
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
              child: Text('المتابعة للدفع'),
            ),
          ],
        ),
      ),
    );
  }
}
