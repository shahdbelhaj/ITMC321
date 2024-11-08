import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Post Section
              _buildNewPostSection(context),
              SizedBox(height: 16.0),
              // User Posts
              UserPost(
                username: 'Mohammed Kahlifa',
                content:
                    ' اليوم أود مشاركة خبر رائع معكم جميعًا! بعد أشهر من العمل الجاد والتعلم المستمر، تمكنت من إتمام مشروعي الأول في مجال الروبوتات بنجاح! ',
                imagePath: 'assets/images/user1.png',
                isCurrentUser: true,
              ),
              UserPost(
                username: 'Ahmed Ali',
                content: 'السلام عليكم ورحمة الله وبركاته',
                imagePath: 'assets/images/user2.png',
                isCurrentUser: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewPostSection(BuildContext context) {
    final TextEditingController postController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user1.png'),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: postController,
                    decoration: InputDecoration(
                      hintText: 'اكتب منشورك',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    maxLines: 4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {},
                ),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم نشر المنشور بنجاح!'),
                        ),
                      );
                      postController.clear();
                    },
                    child: const Text("نشر")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserPost extends StatefulWidget {
  final String username;
  final String content;
  final String imagePath;
  final bool isCurrentUser;

  const UserPost({
    required this.username,
    required this.content,
    required this.imagePath,
    required this.isCurrentUser,
    Key? key,
  }) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool isLiked = false;
  bool isCommenting = false;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.imagePath),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      widget.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (widget.isCurrentUser)
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('تحذير'),
                            content:
                                Text('هل أنت متأكد أنك تريد حذف هذا المنشور؟'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('إلغاء'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('حذف'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(widget.content),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt_outlined,
                          color: isLiked ? Colors.blue : Colors.grey[900]),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    SizedBox(width: 4.0),
                    Text('اعجاب'),
                    IconButton(
                      icon: Icon(Icons.comment_outlined),
                      onPressed: () {
                        setState(() {
                          isCommenting = !isCommenting;
                        });
                      },
                    ),
                    SizedBox(width: 4.0),
                    Text('تعليق'),
                    IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                    SizedBox(width: 4.0),
                    Text('مشاركة'),
                  ],
                ),
              ],
            ),
            if (isCommenting)
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user1.png'),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: ' اكتب تعليقك',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          commentController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
