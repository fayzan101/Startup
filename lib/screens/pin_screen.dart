import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'explorer_dashboard_screen.dart';
import '../services/theme_service.dart';
import '../widgets/connectivity_wrapper.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  String _pin = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _updatePin();
  }

  void _updatePin() {
    _pin = _controllers.map((controller) => controller.text).join();
    if (_pin.length == 6) {
      _verifyPin();
    }
  }

  void _verifyPin() {
    
    print('PIN entered: $_pin');
    
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ExplorerDashboardScreen(
          userName: 'User', 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final primary = Theme.of(context).colorScheme.primary;
    return ConnectivityWrapper(
      showOfflineUI: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: ThemeService.instance.systemUiOverlayForPrimary(lightIcons: true),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: primary, 
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Enter PIN',
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
                              Icons.lock_outline,
                              size: screenWidth * 0.1,
                              color: primary, 
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        Text(
                          'Enter your 6-digit PIN',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                            color: primary, 
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        Text(
                          'Please enter the 6-digit PIN to continue',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: primary.withOpacity(0.7), 
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.06),
                        
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                            (index) => Container(
                              width: screenWidth * 0.12,
                              height: screenWidth * 0.12,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _focusNodes[index].hasFocus
                                      ? primary 
                                      : primary.withOpacity(0.3), 
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                   color: primary, 
                                ),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) => _onPinChanged(value, index),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.08),
                        
                        
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _pin.length == 6 ? _verifyPin : null,
                            style: ElevatedButton.styleFrom(
                              elevation: _pin.length == 6 ? 8 : 0,
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
                        
                        
                        TextButton(
                          onPressed: () {
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Forgot PIN functionality coming soon'),
                                backgroundColor: primary, 
                              ),
                            );
                          },
                          child: Text(
                            'Forgot PIN?',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w500,
                              color: primary, 
                              decoration: TextDecoration.underline,
                            ),
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
} 