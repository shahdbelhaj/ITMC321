import 'package:Bytes/pages/cart_page.dart';
import 'package:Bytes/pages/quantity_selection.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ArduinoNanoPage extends StatelessWidget {
  final String productName = 'Arduino Nano';
  final String productPrice = '35 د.ل';

  const ArduinoNanoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/arduino_nano.jpg',
    ];

    void _navigateToQuantitySelection() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuantitySelectionPage(
            productName: productName,
            productPrice: double.parse(productPrice.replaceAll('\$', '')),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _viewCart,
          ),
        ],
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
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.3),
                                        Colors.grey.withOpacity(0.3),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
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
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon:
                              Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () {
                            // Handle save action
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Product Name and Price
              Text(
                productName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 8.0),
              Text(
                productPrice,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.green),
              ),
              SizedBox(height: 16.0),
              // Specifications
              Text(
                'المواصفات:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.0),
              Text(
                'الميكروكنترولر: ATmega328P\n'
                'السرعة: 16 MHz\n'
                'ذاكرة الفلاش: 32 KB\n'
                'ذاكرة الـ SRAM: 2 KB\n'
                'ذاكرة الـ EEPROM: 1 KB\n'
                'عدد الـ GPIO: 14\n'
                'الجهد التشغيلي: 5V',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: _navigateToQuantitySelection,
                child: Text('أضف إلى السلة'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
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
          title: Text('تقييم ومراجعة'),
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
                decoration: InputDecoration(hintText: 'اكتب مراجعة'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                print('تقييم: $_rating');
                print('مراجعة: ${_reviewController.text}');
                Navigator.of(context).pop();
              },
              child: Text('إرسال'),
            ),
          ],
        );
      },
    );
  }
}
