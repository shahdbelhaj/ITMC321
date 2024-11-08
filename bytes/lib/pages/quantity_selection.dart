import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantitySelectionPage extends StatefulWidget {
  final String productName;
  final double productPrice;

  const QuantitySelectionPage({
    required this.productName,
    required this.productPrice,
    super.key,
  });

  @override
  _QuantitySelectionPageState createState() => _QuantitySelectionPageState();
}

class _QuantitySelectionPageState extends State<QuantitySelectionPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.productPrice * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اختر الكمية',
          style: GoogleFonts.almarai(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/arduino_uno_1.png',
                fit: BoxFit.contain,
                height: 200,
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                widget.productName,
                style: GoogleFonts.almarai(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 38, 66),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'السعر: ${widget.productPrice.toStringAsFixed(2)} د.ل',
                style: GoogleFonts.almarai(
                  fontSize: 18,
                  color: Color.fromARGB(255, 2, 38, 66),
                ),
              ),
            ),
            Divider(height: 32.0, color: Color.fromARGB(255, 2, 38, 66)),
            Text(
              'السعر الإجمالي: ${totalPrice.toStringAsFixed(2)} د.ل',
              style: GoogleFonts.almarai(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 38, 66),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:
                      Icon(Icons.remove, color: Color.fromARGB(255, 2, 38, 66)),
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() {
                        _quantity--;
                      });
                    }
                  },
                ),
                Text(
                  '$_quantity',
                  style: GoogleFonts.almarai(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 38, 66),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Color.fromARGB(255, 2, 38, 66)),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تمت الإضافة بنجاح'),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 2, 61, 107),
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.almarai(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('أضف إلى السلة'),
            ),
          ],
        ),
      ),
    );
  }
}
