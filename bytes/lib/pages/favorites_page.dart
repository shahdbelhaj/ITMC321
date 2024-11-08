import 'package:Bytes/pages/favoriteproducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  Widget _buildCategoryItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 2, 38, 66)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 2, 38, 66),
            fontFamily: GoogleFonts.almarai().fontFamily,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 2, 38, 66)),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'المفضلة',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 38, 66),
                fontFamily: GoogleFonts.almarai().fontFamily,
              ),
            ),
            Divider(),
            _buildCategoryItem(context, Icons.shopping_cart, 'المنتجات', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesProductsPage(),
                ),
              );
            }),
            _buildCategoryItem(context, Icons.school, 'المشاريع', () {
              // Navigate to Projects Favorites Page
            }),
            _buildCategoryItem(context, Icons.event, 'الأحداث', () {
              // Navigate to Events Favorites Page
            }),
          ],
        ),
      ),
    );
  }
}
