import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pin_screen.dart';
import 'signup_screen.dart';
import '../services/theme_service.dart';
import '../widgets/connectivity_wrapper.dart';

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

     final primary = Theme.of(context).colorScheme.primary;
     return ConnectivityWrapper(
       showOfflineUI: true,
       child: AnnotatedRegion<SystemUiOverlayStyle>(
         value: ThemeService.instance.systemUiOverlayForPrimary(lightIcons: false),
               child: Scaffold(
           extendBody: true,
           extendBodyBehindAppBar: false,
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
           
         body: Container(
           width: double.infinity,
           height: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                                     
                   Expanded(
                     flex: 1,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                                                                                                                                                                                                       
                           Container(
                             width: screenWidth * 0.45, 
                             height: screenWidth * 0.45, 
                             decoration: BoxDecoration(
                               color: Theme.of(context).colorScheme.surface,
                               borderRadius: BorderRadius.circular(20),
                             ),
                            child: Center(
                              child: Image.asset(
                                'assets/logo.png',
                                width: screenWidth * 0.35, 
                                height: screenWidth * 0.35, 
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                         SizedBox(height: screenHeight * 0.01),
                           Text(
                           'Ek Click Pe Sab Hojaega',
                           style: GoogleFonts.poppins(
                             fontSize: screenWidth * 0.035,
                             fontWeight: FontWeight.w400,
                                                           color: primary.withOpacity(0.8), 
                             letterSpacing: 0.5,
                           ),
                           textAlign: TextAlign.center,
                         ),
                         SizedBox(height: screenHeight * 0.02),
                                                  
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
                                backgroundColor: primary,
                                foregroundColor: Theme.of(context).colorScheme.primary,
                                elevation: 8,
                                shadowColor: Theme.of(context).shadowColor.withOpacity(0.3),
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
                                  color:Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primary,
                                side: BorderSide(color: primary),
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
     )
     );
  }
}
