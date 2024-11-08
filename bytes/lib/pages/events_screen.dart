import 'package:flutter/material.dart';
import 'event_detail_page.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Map<String, bool> _bookmarkedEvents = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
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
              SizedBox(height: 16.0),
              _buildEventCard(
                context,
                'First Tech Challenge',
                'مسابقة',
                '25 يوليو 2024',
                'assets/images/events1.jpg',
                'تحدي التكنولوجيا الأول هو مسابقة دولية للروبوتات للطلاب في المرحلة الثانوية. يقوم الفرق بتصميم وبناء وبرمجة الروبوتات للتنافس في شكل تحالف ضد فرق أخرى.',
                [
                  'مجموعة روبوتات',
                  'كمبيوتر محمول مع برنامج برمجة',
                  'فريق من 3-10 أعضاء'
                ],
              ),
              _buildEventCard(
                context,
                'كورس برمجة الروبوتات باستعمال اردوينو',
                'تدريب',
                '1 - 5 أغسطس 2024',
                'assets/images/events2.jpg',
                'سوف يعلمك هذا الكورس كيفية برمجة الروبوتات باستخدام أردوينو. ستتعلم أساسيات الإلكترونيات والبرمجة لإنشاء روبوتات وظيفية.',
                [
                  'مجموعة أردوينو المبدئية',
                  'معرفة أساسية بالإلكترونيات',
                  'كمبيوتر محمول'
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(
      BuildContext context,
      String title,
      String eventType,
      String date,
      String imagePath,
      String description,
      List<String> requirements) {
    bool isBookmarked = _bookmarkedEvents[title] ?? false;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              title: title,
              eventType: eventType,
              date: date,
              imagePath: imagePath,
              description: description,
              requirements: requirements,
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
                        BorderRadius.vertical(top: Radius.circular(16.0)),
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
                        if (isBookmarked) {
                          _bookmarkedEvents[title] = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تمت الإزالة من المفضلة'),
                            ),
                          );
                        } else {
                          _bookmarkedEvents[title] = true;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تمت الإضافة إلى المفضلة'),
                            ),
                          );
                        }
                      });
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
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            eventType == 'مسابقة'
                                ? Icons.emoji_events
                                : Icons.school,
                            color: eventType == 'مسابقة'
                                ? Colors.orange
                                : Colors.blue,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            eventType,
                            style: TextStyle(
                              color: eventType == 'مسابقة'
                                  ? Colors.orange
                                  : Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 16.0, color: Colors.blue),
                            SizedBox(width: 4.0),
                            Text(date),
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
