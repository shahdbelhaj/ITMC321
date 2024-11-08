import 'package:flutter/material.dart';
import 'package:Bytes/pages/sign_up_screen.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(80, 181, 209, 1),
              Color.fromARGB(255, 12, 75, 111),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Column(
              children: [
                SizedBox(height: 40.0),
                Text(
                  'BYTES',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'بايتس',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 80.0),
                SizedBox(height: 20.0),
                Image.asset(
                  'assets/images/logo.png',
                  height: 250.0,
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                  ),
                  child: Text(
                    'مرحبا بك',
                    style: TextStyle(
                        color: Color.fromARGB(255, 8, 47, 80),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.white : Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    );
                  }).reversed.toList(),
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                'تجاوز',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
