import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String title;
  final String eventType;
  final String date;
  final String imagePath;
  final String description;
  final List<String> requirements;

  const EventDetailPage({
    super.key,
    required this.title,
    required this.eventType,
    required this.date,
    required this.imagePath,
    required this.description,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              SizedBox(height: 16.0),
              Text(
                description,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'المتطلبات:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ...requirements.map((req) => ListTile(
                    leading: Icon(Icons.check),
                    title: Text(req),
                  )),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 53, 88),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'التسجيل في الحدث',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
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
