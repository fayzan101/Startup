import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'customer_details_screen.dart';
import 'explorer_name_screen.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
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
            'Choose Your Role',
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
                              Icons.person_add,
                              size: screenWidth * 0.1,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Title
                        Text(
                          'Choose Your Role',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4CAF50), // Light green
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        // Subtitle
                        Text(
                          'Select how you want to use Hojaega',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.08),
                        
                        // Customer Card (People who want to be hired)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomerDetailsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.15,
                                  height: screenWidth * 0.15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50).withOpacity(0.1), // Light green
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.work,
                                    size: screenWidth * 0.08,
                                    color: const Color(0xFF4CAF50), // Light green
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'I Want to Work',
                                        style: GoogleFonts.poppins(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF4CAF50), // Light green
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Upload your details to get hired',
                                        style: GoogleFonts.poppins(
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF1B5E20).withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: screenWidth * 0.04,
                                  color: const Color(0xFF1B5E20).withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Explorer Card (People who want to hire)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ExplorerNameScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF1B5E20).withOpacity(0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.15,
                                  height: screenWidth * 0.15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1B5E20).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    size: screenWidth * 0.08,
                                    color: const Color(0xFF1B5E20),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'I Want to Hire',
                                        style: GoogleFonts.poppins(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1B5E20),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Browse and hire skilled workers',
                                        style: GoogleFonts.poppins(
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF1B5E20).withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: screenWidth * 0.04,
                                  color: const Color(0xFF1B5E20).withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Extra padding at bottom
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