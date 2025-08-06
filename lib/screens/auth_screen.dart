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
                   statusBarColor: Color(0xFF1B5E20),
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
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.eco,
                              size: screenWidth * 0.12,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                                                 // App Name
                         Text(
                           'HOJAEGA',
                           style: GoogleFonts.bubblegumSans(
                             fontSize: screenWidth * 0.08,
                             fontWeight: FontWeight.bold,
                                                           color: const Color(0xFF1B5E20),
                             letterSpacing: 2.0,
                           ),
                         ),
                         SizedBox(height: screenHeight * 0.02),
                         Text(
                           'Welcome to your green journey',
                           style: GoogleFonts.poppins(
                             fontSize: screenWidth * 0.035,
                             fontWeight: FontWeight.w400,
                                                           color: const Color(0xFF1B5E20).withOpacity(0.8),
                             letterSpacing: 0.5,
                           ),
                           textAlign: TextAlign.center,
                         ),
                         SizedBox(height: screenHeight * 0.04),
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
                                                                 backgroundColor: const Color(0xFF1B5E20),
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
                                                                 foregroundColor: const Color(0xFF1B5E20),
                                elevation: 0,
                                side: const BorderSide(
                                                                     color: Color(0xFF1B5E20),
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
