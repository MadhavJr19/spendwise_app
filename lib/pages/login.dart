import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money/main.dart';
import 'package:my_money/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true; // Password visibility state

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MY MONEY',
                  style: GoogleFonts.racingSansOne(
                    color: Colors.black,
                    fontSize: 65,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Your Budget Buddy.',
                  style: GoogleFonts.satisfy(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/login.png', // Adjust the path as needed
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 320, // Adjust the width as needed
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone number is required!';
                              } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
                                return 'Enter a valid phone number';
                              } else {
                                return null;
                              }
                            },
                            controller: _idController,
                            decoration: inputDeco('Phone Number', Icons.phone),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 320, // Adjust the width as needed
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required!';
                              } else if (!(value.length >= 6)) {
                                return 'Password must have at least 6 characters';
                              } else {
                                return null;
                              }
                            },
                            controller: _passController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: const BorderSide(color: Color(0xFFD00909), width: .8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: const BorderSide(color: Color(0xFFD00909), width: .8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: const BorderSide(color: Color(0xFFA8A8A8), width: .8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: const BorderSide(color: Color(0xFFA8A8A8), width: .8),
                              ),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle 'Forgot Password?' action here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.satisfy(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: -.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String username = storeClass.store!.getString('username') ?? '';
                          String pass = storeClass.store!.getString('password') ?? '';
                          if (username == _idController.text.trim() && pass == _passController.text.trim()) {
                            await storeClass.store!.setBool('isLogin', true);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size(100, 40), // Smaller button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Smaller border radius
                        ),
                        backgroundColor: Colors.white, // White background
                        side: BorderSide(color: Colors.purple), // Purple border color
                      ),
                      child: Text(
                        'Log IN',
                        style: GoogleFonts.nunito(
                          color: Colors.purple, // Purple text color
                          fontSize: 16, // Adjust font size if needed
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDeco(String hint, [IconData? icon]) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFD00909), width: .8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFD00909), width: .8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFA8A8A8), width: .8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFA8A8A8), width: .8),
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}
