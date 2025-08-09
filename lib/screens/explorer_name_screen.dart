import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/custom_snackbar.dart';
import '../services/theme_service.dart';
import 'explorer_dashboard_screen.dart';
import '../widgets/connectivity_wrapper.dart';

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
      
      print('Explorer name: ${_nameController.text}');
      
      customSnackBar('Success', 'Welcome ${_nameController.text}!', context: context);
      
      
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

    final primary = Theme.of(context).colorScheme.primary;
    return ConnectivityWrapper(
      showOfflineUI: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary, 
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Explorer Setup',
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onPrimary,
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
                        
                        
                        Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              size: screenWidth * 0.1,
                              color: primary, 
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        
                        Text(
                          'Welcome Explorer!',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: primary
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        
                        Text(
                          'Tell us your name to get started',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: primary.withOpacity(0.7), 
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.06),
                        
                        
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _nameFocusNode.hasFocus
                                  ? primary 
                                  : primary.withOpacity(0.3), 
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
                              color: primary, 
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your full name',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w400,
                                color: primary.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: primary.withOpacity(0.7),
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
                        
                        
                          Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: screenWidth * 0.035,
                               color: primary.withOpacity(0.7), 
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                'Enter your full name (minimum 3 characters)',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w400,
                                   color: primary.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _isValidName ? _continueAsExplorer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isValidName
                                  ? primary 
                                  : primary.withOpacity(0.3), 
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              elevation: _isValidName ? 8 : 0,
                              shadowColor: Theme.of(context).shadowColor.withOpacity(0.3),
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
                        
                        
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                             color: primary.withOpacity(0.05), 
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                               color: primary.withOpacity(0.1), 
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
                                   color: primary, 
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
    )
    );
  }

  Widget _buildBenefitItem(String text, IconData icon, double screenWidth) {
    return Row(
      children: [
        Icon(
          icon,
          size: screenWidth * 0.035,
          color: const Color(0xFF4CAF50).withOpacity(0.7), 
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.03,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4CAF50).withOpacity(0.8), 
            ),
          ),
        ),
      ],
    );
  }
} 