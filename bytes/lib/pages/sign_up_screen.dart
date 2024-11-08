import 'package:Bytes/main.dart';
import 'package:Bytes/pages/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasMinLength = false;
  bool showChecklist = false;

  void _checkPassword(String password) {
    setState(() {
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasDigits = password.contains(RegExp(r'[0-9]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
      hasMinLength = password.length >= 8;
    });
  }

  void _submitForm() {
    setState(() {
      showChecklist = true;
    });

    if (_formKey.currentState!.validate() && _isPasswordValid()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.0),
                Center(
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
                Text('اسم المستخدم',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'user_123',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.grey),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم المستخدم';
                    }
                    if (value.length < 3 || value.length > 30) {
                      return 'يجب أن يتراوح طول اسم المستخدم بين 3 و 30 حرفًا';
                    }

                    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                      return 'يحتوي اسم المستخدم على أحرف وأرقام وشرطات سفلية فقط';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('البريد الالكتروني',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد الإلكتروني';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'الرجاء إدخال بريد إلكتروني صالح';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('كلمة المرور',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'ادخل كلمة المرور',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  onChanged: (value) {
                    _checkPassword(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور';
                    }

                    return null;
                  },
                ),
                if (showChecklist && !_isPasswordValid())
                  Container(
                    child: _buildPasswordChecklist(),
                  ),
                SizedBox(height: 16.0),
                Text('تأكيد كلمة المرور',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'أعد إدخال كلمة المرور',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء تأكيد كلمة المرور';
                    }
                    if (value != _passwordController.text) {
                      return 'كلمتا المرور غير متطابقتين';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 8, 47, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  child: Text(
                    'إنشاء الحساب',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'لديك حساب؟ ',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        TextSpan(
                          text: 'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isPasswordValid() {
    return hasUppercase && hasDigits && hasLowercase && hasMinLength;
  }

  Widget _buildPasswordChecklist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChecklistItem('يجب أن يحتوي على حرف كبير', hasUppercase),
        _buildChecklistItem('يجب أن يحتوي على رقم', hasDigits),
        _buildChecklistItem('يجب أن يتكون من 8 أحرف على الأقل', hasMinLength),
      ],
    );
  }

  Widget _buildChecklistItem(String text, bool isChecked) {
    return Row(
      children: [
        Icon(
          isChecked ? Icons.check : Icons.close,
          color: isChecked ? Colors.green : Colors.red,
          size: 20.0,
          shadows: [
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            text,
            style: TextStyle(
              color: isChecked ? Colors.green : Colors.red,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 34, 12, 12).withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
