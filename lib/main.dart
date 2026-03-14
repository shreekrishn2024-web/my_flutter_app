import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/otp': (context) => OtpVerificationScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

// ------------------ Login Screen ------------------
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate OTP sending (e.g., network call)
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navigate to OTP verification screen with phone number
      Navigator.pushNamed(context, '/otp', arguments: _phoneController.text);
    }
  }

  void _truecallerVerify() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Truecaller verification - to be implemented')),
    );
  }

  void _googleSignIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google Sign-In - to be implemented')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Top Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.chat_bubble, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "MySivi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "India's #1 English Learning App",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Trusted by 50 Lakh+ Learners",
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),

            SizedBox(height: 30),

            // Phone Input with Form
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixText: "+91 ",
                    hintText: "Enter mobile number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    counterText: "", // Hide the default length counter
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    return null;
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            // Send OTP Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _sendOtp,
                      child: Text("Send OTP"),
                    ),
            ),

            SizedBox(height: 20),

            Text("or"),

            SizedBox(height: 20),

            // Truecaller Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _truecallerVerify,
                child: Text("Verify via Truecaller"),
              ),
            ),

            SizedBox(height: 20),

            // Google Login
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: Icon(Icons.login, color: Colors.black),
                label: Text(
                  "Sign in with Google",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: _googleSignIn,
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "By continuing, I accept Terms of Use",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ------------------ OTP Verification Screen ------------------
class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    // Get phone number from arguments
    final String phoneNumber = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the 6-digit OTP sent to',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '+91 $phoneNumber',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                counterText: '',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, letterSpacing: 8),
            ),
            SizedBox(height: 30),
            _isVerifying
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (_otpController.text.length == 6) {
                        setState(() => _isVerifying = true);
                        // Simulate OTP verification
                        await Future.delayed(Duration(seconds: 2));
                        setState(() => _isVerifying = false);
                        // Navigate to home screen
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter 6-digit OTP')),
                        );
                      }
                    },
                    child: Text('Verify OTP'),
                  ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Resend OTP logic (you can implement)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP resent (simulated)')),
                );
              },
              child: Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Home Screen (Dummy) ------------------
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Welcome to MySivi!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
