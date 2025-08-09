import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/Colors/color_resources.dart';

class OfflineUIWidget extends StatelessWidget {
  final MediaQueryData mediaQuery;

  const OfflineUIWidget({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: mediaQuery.size.width * 0.2,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: mediaQuery.size.height * 0.02),
          Text(
            'No Internet Connection',
            style: GoogleFonts.sora(
              fontSize: mediaQuery.size.width * 0.045,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
} 