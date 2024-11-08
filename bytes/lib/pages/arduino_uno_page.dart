import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Bytes/pages/cart_page.dart';
import 'package:Bytes/pages/quantity_selection.dart';

class ArduinoUnoPage extends StatefulWidget {
  const ArduinoUnoPage({super.key});

  @override
  _ArduinoUnoPageState createState() => _ArduinoUnoPageState();
}

class _ArduinoUnoPageState extends State<ArduinoUnoPage> {
  final String productName = 'Arduino Uno';
  final String productPrice = '50.00 د.ل';
  bool isBookmarked = false;

  final List<String> imgList = [
    'assets/images/arduino_uno_1.png',
    'assets/images/arduino_uno_2.png',
  ];

  void _navigateToQuantitySelection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuantitySelectionPage(
          productName: productName,
          productPrice: double.parse(productPrice.replaceAll('د.ل', '')),
        ),
      ),
    );
  }

  void _viewCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                    ),
                    items: imgList
                        .map((item) => Stack(
                              children: [
                                Image.asset(
                                  item,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.yellow[700],
                          ),
                          onPressed: () {
                            setState(() {
                              if (isBookmarked) {
                                _showSnackbar(
                                    context, 'تمت الإزالة من المفضلة');
                              } else {
                                _showSnackbar(
                                    context, 'تمت الإضافة إلى المفضلة');
                              }
                              isBookmarked = !isBookmarked;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            showRatingDialog(context);
                          },
                          child: Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < 4 ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                  );
                                }),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '(24)',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                productName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 8.0),
              Text(
                ' السعر: 50.00 د.ل',
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 38, 66),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Divider(height: 32.0, color: Colors.grey),
              // Specifications
              const Text(
                'المواصفات:',
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 38, 66),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              const Text(
                'الميكروكنترولر: ATmega328P\n'
                'السرعة: 16 MHz\n'
                'ذاكرة الفلاش: 32 KB\n'
                'ذاكرة الـ SRAM: 2 KB\n'
                'ذاكرة الـ EEPROM: 1 KB\n'
                'عدد الـ GPIO: 14\n'
                'الجهد التشغيلي: 5V',
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 38, 66), fontSize: 17),
              ),
              SizedBox(height: 16.0),
              // Add to Cart Button
              ElevatedButton(
                onPressed: _navigateToQuantitySelection,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Color.fromARGB(255, 2, 61, 107), // White text color
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: GoogleFonts.almarai().fontFamily,
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('أضف إلى السلة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double _rating = 0;
        TextEditingController _reviewController = TextEditingController();

        return AlertDialog(
          title: Text('تقييم المنتج'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(hintText: 'اكتب تقييمك'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                print('تقييم: $_rating');
                print('مراجعة: ${_reviewController.text}');
                Navigator.of(context).pop();
              },
              child: Text(
                'إرسال',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
