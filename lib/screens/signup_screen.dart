import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otp_verification_screen.dart';
import '../utils/custom_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isValidPhone = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _validatePhone(String value) {
    // Basic phone validation (10 digits)
    setState(() {
      _isValidPhone = value.length == 10 && RegExp(r'^[0-9]+$').hasMatch(value);
    });
  }

  void _sendOtp() {
    if (_isValidPhone) {
      // TODO: Implement OTP sending logic
      print('Sending OTP to: ${_phoneController.text}');
      
      customSnackBar('Success', 'OTP sent to ${_phoneController.text}', context: context);
      
      // Navigate to OTP verification screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            phoneNumber: _phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF4CAF50), // Light green
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark, // For iOS
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF4CAF50), // Light green
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Sign Up',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        
                        // Logo and Title
                        Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                                                         child: Icon(
                               Icons.phone_android,
                               size: screenWidth * 0.1,
                               color: const Color(0xFF4CAF50), // Light green
                             ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        Text(
                          'Enter your phone number',
                                                      style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        Text(
                          'We\'ll send you a verification code',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.06),
                        
                        // Phone Number Input
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _phoneFocusNode.hasFocus
                                  ? const Color(0xFF4CAF50) // Light green
                                  : const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50), // Light green
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    bottomLeft: Radius.circular(13),
                                  ),
                                ),
                                child: Text(
                                  '+92',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocusNode,
                                  keyboardType: TextInputType.phone,
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4CAF50), // Light green
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter phone number',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF4CAF50).withOpacity(0.5), // Light green
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onChanged: _validatePhone,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        // Phone number hint
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: screenWidth * 0.035,
                              color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                'Enter your 10-digit mobile number without country code',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: screenHeight * 0.08),
                        
                        // Send OTP Button
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _isValidPhone ? _sendOtp : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isValidPhone
                                  ? const Color(0xFF4CAF50) // Light green
                                  : const Color(0xFF4CAF50).withOpacity(0.3), // Light green with opacity
                              foregroundColor: Colors.white,
                              elevation: _isValidPhone ? 8 : 0,
                              shadowColor: Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Send OTP',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Terms and Conditions
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'By continuing, you agree to our Terms of Service and Privacy Policy',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        
                        // Extra padding at bottom to prevent overflow
                        SizedBox(height: screenHeight * 0.05),
                      ],
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
} 