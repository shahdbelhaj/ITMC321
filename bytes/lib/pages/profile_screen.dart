import 'package:Bytes/pages/favorites_page.dart';
import 'package:Bytes/pages/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/user1.png'),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mohammed Khalifa',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'mokhalifa@example.com',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: ListView(
                children: [
                  _buildOptionItem(context, Icons.delivery_dining, 'الطلبات'),
                  _buildOptionItem(
                      context, Icons.location_on, 'العناوين المحفوظة'),
                  _buildOptionItem(context, Icons.edit, 'تعديل حسابي'),
                  _buildOptionItem(context, Icons.settings, 'الاعدادات'),
                  _buildOptionItem(context, Icons.favorite, 'المفضلة'),
                  _buildOptionItem(context, Icons.notifications, 'إشعارات'),
                  _buildOptionItem(context, Icons.logout, 'تسجيل الخروج'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (title == 'تسجيل الخروج') {
          _showSignOutDialog(context);
        } else if (title == 'المفضلة') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesPage()),
          );
        } else {
          // Handle other cases if needed
        }
      },
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد تسجيل الخروج'),
          content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('تسجيل الخروج'),
            ),
          ],
        );
      },
    );
  }
}
