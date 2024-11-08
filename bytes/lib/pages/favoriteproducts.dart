import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesProductsPage extends StatelessWidget {
  const FavoritesProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = [
      {
        'name': 'Raspberry Pi 4',
        'price': 150.0,
        'image': 'assets/images/raspberry_pi_4.jpg'
      },
      {
        'name': 'Arduino Uno',
        'price': 50.0,
        'image': 'assets/images/arduino_uno_1.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المنتجات المفضلة',
          style: GoogleFonts.almarai(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final item = favoriteProducts[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Image.asset(
                  item['image'] as String,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  item['name'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 38, 66),
                    fontFamily: GoogleFonts.almarai().fontFamily,
                  ),
                ),
                subtitle: Text(
                  'السعر: ${item['price']} د.ل',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 2, 38, 66),
                    fontFamily: GoogleFonts.almarai().fontFamily,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
