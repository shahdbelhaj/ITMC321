import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final Map<String, bool> _bookmarkedProjects = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'بحث....',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16.0),
              // Project Cards
              _buildProjectCard(
                context,
                'Blinking LED',
                'مبتدئ',
                '30 دقيقة',
                'assets/images/project1.jpg',
                [
                  'LED',
                  'مقاوم 220 أوم',
                  'لوحة تجارب',
                  'أسلاك توصيل',
                  'Arduino UNO'
                ],
                [
                  'توصيل LED بلوحة التجارب',
                  'توصيل المقاوم بـ LED',
                  'توصيل الأسلاك من LED إلى Arduino',
                  'كتابة الكود فى Arduino IDE'
                ],
                '''
void setup() {
  pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13, HIGH);
  delay(1000);
  digitalWrite(13, LOW);
  delay(1000);
}
''',
              ),
              _buildProjectCard(
                context,
                'نظام مراقبة درجة الحرارة والرطوبة',
                'متوسط',
                'ساعة ونصف',
                'assets/images/project2.jpg',
                [
                  'DHT11 مستشعر',
                  'لوحة تجارب',
                  'أسلاك توصيل',
                  'Arduino',
                  'شاشة LCD'
                ],
                [
                  'توصيل مستشعر DHT11 بلوحة التجارب',
                  'توصيل الأسلاك من مستشعر DHT11 إلى Arduino',
                  'توصيل شاشة LCD بـ Arduino',
                  'كتابة الكود قى Arduino IDE'
                ],
                '''
#include <DHT.h>
#include <LiquidCrystal.h>

#define DHTPIN 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  lcd.begin(16, 2);
  dht.begin();
}

void loop() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  lcd.setCursor(0, 0);
  lcd.print("Temp: ");
  lcd.print(t);
  lcd.print(" C");
  lcd.setCursor(0, 1);
  lcd.print("Humidity: ");
  lcd.print(h);
  lcd.print(" %");
  delay(2000);
}
''',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String level,
    String time,
    String imagePath,
    List<String> components,
    List<String> steps,
    String code,
  ) {
    Color levelColor;

    switch (level) {
      case 'مبتدئ':
        levelColor = Colors.green;
        TextStyle(fontFamily: GoogleFonts.almarai().fontFamily);
        break;
      case 'متوسط':
        levelColor = Color.fromARGB(255, 222, 200, 4);
        TextStyle(fontFamily: GoogleFonts.almarai().fontFamily, fontSize: 16);
        break;
      case 'محترف':
        levelColor = Colors.red;
        TextStyle(fontFamily: GoogleFonts.almarai().fontFamily);
        break;
      default:
        levelColor = Colors.grey;
    }

    bool isBookmarked = _bookmarkedProjects[title] ?? false;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailPage(
              title: title,
              level: level,
              time: time,
              imagePath: imagePath,
              components: components,
              steps: steps,
              code: code,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16.0)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _bookmarkedProjects[title] = !isBookmarked;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isBookmarked
                              ? 'تمت الإزالة من المفضلة'
                              : 'تمت الإضافة إلى المفضلة'),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        isBookmarked ? Icons.favorite : Icons.favorite_border,
                        color: isBookmarked ? Colors.yellow : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'المرحلة: ',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.almarai().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: level,
                              style: TextStyle(
                                color: levelColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16.0, color: Colors.blue),
                            const SizedBox(width: 4.0),
                            Text(time),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailPage extends StatefulWidget {
  final String title;
  final String level;
  final String time;
  final String imagePath;
  final List<String> components;
  final List<String> steps;
  final String code;

  const ProjectDetailPage({
    required this.title,
    required this.level,
    required this.time,
    required this.imagePath,
    required this.components,
    required this.steps,
    required this.code,
    super.key,
  });

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  bool _isCodeExpanded = false;

  void _addToCart() {
    // Logic to add components to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تمت إضافة جميع المنتجات إلى العربة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    double totalPrice = 50.0 + 5.0 + 2.0 + 5.0 + 3.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              // Project Image
              Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Project Title, Level, and Time
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'المرحلة: ${widget.level}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'الوقت المقدر: ${widget.time}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              const Divider(),

              Text(
                'المكونات اللازمة:',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...widget.components.map((component) => Text('- $component')),
              const SizedBox(height: 16.0),
              const Divider(),

              Text(
                'الخطوات لإتمام المشروع:',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...widget.steps.map((step) => Text('- $step')),
              const SizedBox(height: 16.0),
              const Divider(),
              // Expandable Code Section
              ExpansionTile(
                title: const Text(
                  'الكود',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      widget.code,
                      style: const TextStyle(fontFamily: 'Courier'),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
                initiallyExpanded: _isCodeExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isCodeExpanded = expanded;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              const Divider(),
              const SizedBox(height: 20.0),
              // Component Slider
              Container(
                height: 190.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildComponentCard(
                        'assets/images/arduino_uno_1.png', 'Arduino Uno', 50.0),
                    _buildComponentCard('assets/images/led.jpg', 'LED', 5.0),
                    _buildComponentCard(
                        'assets/images/resistor.jpg', 'مقاوم 220 أوم', 2.0),
                    _buildComponentCard(
                        'assets/images/breadboard.jpg', 'لوحة تجارب', 5.0),
                    _buildComponentCard(
                        'assets/images/cables.jpg', 'أسلاك توصيل', 3.0),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Total Price
              Text(
                ' السعر إجمالي: ${totalPrice.toStringAsFixed(2)}د.ل',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 6, 38, 86), // Text color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(
                    'إضافة المنتجات إلى العربة',
                    style: TextStyle(
                        fontFamily: GoogleFonts.almarai().fontFamily,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComponentCard(String imagePath, String name, double price) {
    return Container(
      width: 130.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.3,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '${price.toStringAsFixed(2)} د.ل',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
