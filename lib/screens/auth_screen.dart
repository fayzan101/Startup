import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pin_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
         body: Container(
           width: double.infinity,
           height: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                                     // Top section with logo and title
                   Expanded(
                     flex: 1,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                                                                                                                                                                                                       // Logo Container
                           Container(
                             width: screenWidth * 0.45, // 45% of screen width (increased from 35%)
                             height: screenWidth * 0.45, // 45% of screen width (increased from 35%)
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20),
                             ),
                            child: Center(
                              child: Image.asset(
                                'assets/logo.png',
                                width: screenWidth * 0.35, // 35% of screen width (increased from 25%)
                                height: screenWidth * 0.35, // 35% of screen width (increased from 25%)
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                         SizedBox(height: screenHeight * 0.01),
                         Text(
                           'Welcome to your green journey',
                           style: GoogleFonts.poppins(
                             fontSize: screenWidth * 0.035,
                             fontWeight: FontWeight.w400,
                                                           color: const Color(0xFF4CAF50).withOpacity(0.8), // Light green
                             letterSpacing: 0.5,
                           ),
                           textAlign: TextAlign.center,
                         ),
                         SizedBox(height: screenHeight * 0.02),
                                                   // Sign In Button
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                                                         child: ElevatedButton(
                               onPressed: () {
                                 print('Sign In button pressed');
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => const PinScreen()),
                                 );
                               },
                              style: ElevatedButton.styleFrom(
                                                                 backgroundColor: const Color(0xFF4CAF50), // Light green
                                foregroundColor: Colors.white,
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Sign Up Button
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                                                         child: ElevatedButton(
                               onPressed: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                 );
                               },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                                                 foregroundColor: const Color(0xFF4CAF50), // Light green
                                elevation: 0,
                                side: const BorderSide(
                                                                     color: Color(0xFF4CAF50), // Light green
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                                     
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
