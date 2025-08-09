import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../utils/custom_snackbar.dart';
import '../services/theme_service.dart';
import 'user_type_screen.dart';
import '../widgets/connectivity_wrapper.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  String _otp = '';
  int _timeLeft = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    if (_canResend) {
      setState(() {
        _timeLeft = 60;
        _canResend = false;
      });
      _startTimer();
      
      
      print('Resending OTP to: ${widget.phoneNumber}');
      
      customSnackBar('Success', 'OTP resent to ${widget.phoneNumber}', context: context);
    }
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _updateOtp();
  }

  void _updateOtp() {
    _otp = _controllers.map((controller) => controller.text).join();
  }

  void _verifyOtp() {
    if (_otp.length == 6) {
      
      print('OTP entered: $_otp');
      
      customSnackBar('Success', 'OTP verified: $_otp', context: context);
      
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserTypeScreen()),
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
            'OTP Verification',
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
                              Icons.verified_user,
                              size: screenWidth * 0.1,
                              color: primary, 
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        
                        Text(
                          'Verification',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: primary, 
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        
                        Text(
                          'Check your phone we have sent you the Pin',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: primary.withOpacity(0.7), 
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: screenHeight * 0.02),
                        
                        
                        Text(
                          '+92 ${widget.phoneNumber}',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: primary, 
                          ),
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
                                onChanged: (value) => _onOtpChanged(value, index),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _otp.length == 6 ? _verifyOtp : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _otp.length == 6
                                  ? primary 
                                  : primary.withOpacity(0.3), 
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              elevation: _otp.length == 6 ? 8 : 0,
                              shadowColor: Theme.of(context).shadowColor.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Verify',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.04),
                        
                        
                        Text(
                          'Resend code in ${_formatTime(_timeLeft)}',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: primary.withOpacity(0.7), 
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.03),
                        
                        
                        if (_canResend)
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: _resendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary, 
                                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                elevation: 8,
                                shadowColor: Theme.of(context).shadowColor.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Resend OTP',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
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
    ));
  }
} 