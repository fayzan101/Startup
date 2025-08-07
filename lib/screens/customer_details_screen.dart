import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/custom_snackbar.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _contactFocusNode = FocusNode();
  final FocusNode _cnicFocusNode = FocusNode();
  final FocusNode _roleFocusNode = FocusNode();
  
  bool _isFormValid = false;

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _cnicController.dispose();
    _roleController.dispose();
    _nameFocusNode.dispose();
    _contactFocusNode.dispose();
    _cnicFocusNode.dispose();
    _roleFocusNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.trim().isNotEmpty &&
          _contactController.text.trim().length == 11 &&
          _cnicController.text.trim().length == 13 &&
          _roleController.text.trim().isNotEmpty;
    });
  }

  void _submitDetails() {
    if (_isFormValid) {
      // TODO: Implement details submission logic
      print('Customer Details:');
      print('Name: ${_nameController.text}');
      print('Contact: ${_contactController.text}');
      print('CNIC: ${_cnicController.text}');
      print('Role: ${_roleController.text}');
      
      customSnackBar('Success', 'Your details have been uploaded successfully!', context: context);
      
      // TODO: Navigate to customer dashboard or next screen
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerDashboard()));
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
            'Upload Your Details',
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
                              Icons.work,
                              size: screenWidth * 0.1,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Title
                        Text(
                          'Get Hired!',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50)
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        // Subtitle
                        Text(
                          'Upload your details so people can hire you',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.06),
                        
                        // Name Input
                        _buildInputField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          label: 'Full Name',
                          hint: 'Enter your full name',
                          icon: Icons.person_outline,
                          inputType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                          onChanged: (value) => _validateForm(),
                        ),
                        
                        SizedBox(height: screenHeight * 0.03),
                        
                        // Contact Input
                        _buildInputField(
                          controller: _contactController,
                          focusNode: _contactFocusNode,
                          label: 'Contact Number',
                          hint: 'Enter your contact number',
                          icon: Icons.phone,
                          inputType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          onChanged: (value) => _validateForm(),
                        ),
                        
                        SizedBox(height: screenHeight * 0.03),
                        
                        // CNIC Input
                        _buildInputField(
                          controller: _cnicController,
                          focusNode: _cnicFocusNode,
                          label: 'CNIC Number',
                          hint: 'Enter your CNIC (13 digits)',
                          icon: Icons.credit_card,
                          inputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(13),
                          ],
                          onChanged: (value) => _validateForm(),
                        ),
                        
                        SizedBox(height: screenHeight * 0.03),
                        
                        // Role Input
                        _buildInputField(
                          controller: _roleController,
                          focusNode: _roleFocusNode,
                          label: 'Your Role/Skill',
                          hint: 'e.g., Electrician, Plumber, Carpenter',
                          icon: Icons.work_outline,
                          inputType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => _validateForm(),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _isFormValid ? _submitDetails : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFormValid
                                  ? const Color(0xFF4CAF50) // Light green
                                  : const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                              foregroundColor: Colors.white,
                              elevation: _isFormValid ? 8 : 0,
                              shadowColor: Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Upload Details',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        // Info Card
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
                                'What happens next?',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4CAF50), // Light green
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              _buildInfoItem('Your details will be visible to potential employers', Icons.visibility, screenWidth),
                              SizedBox(height: screenHeight * 0.01),
                              _buildInfoItem('Employers can contact you directly', Icons.phone_enabled, screenWidth),
                              SizedBox(height: screenHeight * 0.01),
                              _buildInfoItem('You can update your details anytime', Icons.edit, screenWidth),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    required TextInputType inputType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    required Function(String) onChanged,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: focusNode.hasFocus
                  ? const Color(0xFF4CAF50) // Light green
                  : const Color(0xFF4CAF50).withOpacity(0.3), // Light green
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: inputType,
            textCapitalization: textCapitalization,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4CAF50), // Light green
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4CAF50).withOpacity(0.5), // Light green
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                size: screenWidth * 0.05,
              ),
            ),
            inputFormatters: inputFormatters,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String text, IconData icon, double screenWidth) {
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