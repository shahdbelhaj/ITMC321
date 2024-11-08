import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _filters = ['الكل', 'اردوينو', 'راسبيري بي', 'ESP'];
  String _selectedFilter = 'الكل';
  List<Map<String, String>> _allItems = [
    {
      'name': 'Arduino Uno',
      'category': 'اردوينو',
      'price': '50 د.ل',
      'image': 'assets/images/arduino_uno_1.png'
    },
    {
      'name': 'Arduino Nano',
      'category': 'اردوينو',
      'price': '35 د.ل',
      'image': 'assets/images/arduino_nano.jpg'
    },
    {
      'name': 'Arduino Mega',
      'category': 'اردوينو',
      'price': '45 د.ل',
      'image': 'assets/images/arduino_mega.jpg'
    },
    {
      'name': 'Arduino Pro Mini',
      'category': 'اردوينو',
      'price': '40 د.ل',
      'image': 'assets/images/arduino_pro_mini.jpg'
    },
    {
      'name': 'Raspberry Pi 4',
      'category': 'راسبيري بي',
      'price': '150 د.ل',
      'image': 'assets/images/raspberry_pi_4.jpg'
    },
    {
      'name': 'Raspberry Pi Zero',
      'category': 'راسبيري بي',
      'price': '70 د.ل',
      'image': 'assets/images/raspberry_pi_zero.png'
    },
    {
      'name': 'Raspberry Pi 3',
      'category': 'راسبيري بي',
      'price': '50 د.ل',
      'image': 'assets/images/raspberry_pi_3.jpg'
    },
    {
      'name': 'Raspberry Pi Model B',
      'category': 'راسبيري بي',
      'price': '130 د.ل',
      'image': 'assets/images/raspberry_pi_model_b.jpg'
    },
    {
      'name': 'ESP8266',
      'category': 'ESP',
      'price': '15 د.ل',
      'image': 'assets/images/esp8266.jpg'
    },
    {
      'name': 'ESP32 Cam',
      'category': 'ESP',
      'price': '25 د.ل',
      'image': 'assets/images/esp32_cam.jpg'
    },
    {
      'name': 'ESP8285',
      'category': 'ESP',
      'price': '10 د.ل',
      'image': 'assets/images/esp8285.jpg'
    },
    {
      'name': 'ESP32-S2',
      'category': 'ESP',
      'price': '7 د.ل',
      'image': 'assets/images/esp32_s2.jpg'
    },
  ];
  List<Map<String, String>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filterItems();
  }

  void _filterItems() {
    setState(() {
      if (_selectedFilter == 'الكل') {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems
            .where((item) => item['category'] == _selectedFilter)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بحث'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            onSelected: (String result) {
              setState(() {
                _selectedFilter = result;
                _filterItems();
              });
            },
            itemBuilder: (BuildContext context) {
              return _filters.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'بحث....',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _filteredItems = _allItems
                      .where((item) => item['name']!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return _buildCard(context, _filteredItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, String> product) {
    return GestureDetector(
      onTap: () {
        // Implement navigation to product detail page if needed
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          child: Row(
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(product['price']!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
