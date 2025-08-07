import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/custom_snackbar.dart';
import 'explorer_dashboard_screen.dart';

class ExplorerNameScreen extends StatefulWidget {
  const ExplorerNameScreen({super.key});

  @override
  State<ExplorerNameScreen> createState() => _ExplorerNameScreenState();
}

class _ExplorerNameScreenState extends State<ExplorerNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _isValidName = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _validateName(String value) {
    setState(() {
      _isValidName = value.trim().length >= 2;
    });
  }

  void _continueAsExplorer() {
    if (_isValidName) {
      // TODO: Implement explorer registration logic
      print('Explorer name: ${_nameController.text}');
      
      customSnackBar('Success', 'Welcome ${_nameController.text}!', context: context);
      
      // Navigate to explorer dashboard with name
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => ExplorerDashboardScreen(userName: _nameController.text.trim()),
        )
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
            'Explorer Setup',
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
                              Icons.search,
                              size: screenWidth * 0.1,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Title
                        Text(
                          'Welcome Explorer!',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50)
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        // Subtitle
                        Text(
                          'Tell us your name to get started',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.06),
                        
                        // Name Input Field
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _nameFocusNode.hasFocus
                                  ? const Color(0xFF4CAF50) // Light green
                                  : const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your full name',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4CAF50).withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Color(0xFF4CAF50).withOpacity(0.7),
                                size: screenWidth * 0.05,
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                            ],
                            onChanged: _validateName,
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        // Name hint
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
                                'Enter your full name (minimum 3 characters)',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w400,
                                  color:Color(0xFF4CAF50).withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Continue Button
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _isValidName ? _continueAsExplorer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isValidName
                                  ? const Color(0xFF4CAF50) // Light green
                                  : const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                              foregroundColor: Colors.white,
                              elevation: _isValidName ? 8 : 0,
                              shadowColor: Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Explorer benefits
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.05), // Light green
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF4CAF50).withOpacity(0.1), // Light green
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'As an Explorer, you can:',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4CAF50), // Light green
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              _buildBenefitItem('Browse skilled workers by category', Icons.category, screenWidth),
                              SizedBox(height: screenHeight * 0.01),
                              _buildBenefitItem('Filter by location and ratings', Icons.filter_list, screenWidth),
                              SizedBox(height: screenHeight * 0.01),
                              _buildBenefitItem('Contact workers directly', Icons.phone, screenWidth),
                            ],
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

  Widget _buildBenefitItem(String text, IconData icon, double screenWidth) {
    return Row(
      children: [
        Icon(
          icon,
          size: screenWidth * 0.035,
          color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.03,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4CAF50).withOpacity(0.8), // Light green
            ),
          ),
        ),
      ],
    );
  }
} 