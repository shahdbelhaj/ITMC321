import 'package:Bytes/pages/arduino_uno_page.dart';
import 'package:Bytes/pages/raspberry_pi_4.dart';
import 'package:flutter/material.dart';
import 'package:Bytes/widgets/product_search.dart';

import 'package:Bytes/pages/arduino_nano_page.dart';
import 'package:Bytes/pages/esp8266_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, String>> arduinoProducts = [
    {
      'name': 'Arduino Uno',
      'price': '50 د.ل',
      'image': 'assets/images/arduino_uno_1.png',
    },
    {
      'name': 'Arduino Nano',
      'price': '35 د.ل',
      'image': 'assets/images/arduino_nano.jpg',
    },
    {
      'name': 'Arduino Mega',
      'price': '45 د.ل',
      'image': 'assets/images/arduino_mega.jpg',
    },
    {
      'name': 'Arduino Pro Mini',
      'price': '40 د.ل',
      'image': 'assets/images/arduino_pro_mini.jpg',
    },
  ];

  final List<Map<String, String>> raspberryPiProducts = [
    {
      'name': 'Raspberry Pi 4',
      'price': '150 د.ل',
      'image': 'assets/images/raspberry_pi_4.jpg',
    },
    {
      'name': 'Raspberry Pi Zero',
      'price': '70 د.ل',
      'image': 'assets/images/raspberry_pi_zero.png',
    },
    {
      'name': 'Raspberry Pi 3',
      'price': '50 د.ل',
      'image': 'assets/images/raspberry_pi_3.jpg',
    },
    {
      'name': 'Raspberry Pi Model B',
      'price': '130 د.ل',
      'image': 'assets/images/raspberry_pi_model_b.jpg',
    },
  ];

  final List<Map<String, String>> espProducts = [
    {
      'name': 'ESP8266',
      'price': '15 د.ل',
      'image': 'assets/images/esp8266.jpg',
    },
    {
      'name': 'ESP32-CAM',
      'price': '25 د.ل',
      'image': 'assets/images/esp32_cam.jpg',
    },
    {
      'name': 'ESP8285',
      'price': '10 د.ل',
      'image': 'assets/images/esp8285.jpg',
    },
    {
      'name': 'ESP32-S2',
      'price': '7 د.ل',
      'image': 'assets/images/esp32_s2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'بحث....',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryCircle(context, Icons.build, 'معدات'),
                  _buildCategoryCircle(context, Icons.sensors, 'حساسات'),
                  _buildCategoryCircle(
                      context, Icons.battery_std_sharp, 'بطريات'),
                  _buildCategoryCircle(context, Icons.computer, 'لوحات'),
                ],
              ),
              SizedBox(height: 16.0),
              _buildSectionTitle(context, 'اردوينو'),
              _buildHorizontalCardList(context, arduinoProducts),
              _buildSectionTitle(context, 'راسبيري بي'),
              _buildHorizontalCardList(context, raspberryPiProducts),
              _buildSectionTitle(context, 'ESP'),
              _buildHorizontalCardList(context, espProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCircle(
      BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey[200],
          child: IconButton(
            icon: Icon(icon, size: 30.0),
            color: Color.fromARGB(255, 6, 33, 75),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'عرض الكل',
            style: TextStyle(
              fontSize: 12.0,
              decoration: TextDecoration.underline,
              color: Color.fromARGB(255, 6, 67, 116),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCardList(
      BuildContext context, List<Map<String, String>> products) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildCard(context, products[index]);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, String> product) {
    return GestureDetector(
      onTap: () {
        if (product['name'] == 'Arduino Nano') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ArduinoNanoPage(),
            ),
          );
        } else if (product['name'] == 'Raspberry Pi 4') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RaspberryPi4Page(),
            ),
          );
        } else if (product['name'] == 'Arduino Uno') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ArduinoUnoPage(),
            ),
          );
        } else if (product['name'] == 'ESP8266') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ESP8266Page(),
            ),
          );
        }
      },
      child: Container(
        width: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(product['price']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
