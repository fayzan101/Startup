import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/custom_snackbar.dart';

class ServiceWorkersScreen extends StatefulWidget {
  final String serviceName;
  final String city;
  
  const ServiceWorkersScreen({
    super.key,
    required this.serviceName,
    required this.city,
  });

  @override
  State<ServiceWorkersScreen> createState() => _ServiceWorkersScreenState();
}

class _ServiceWorkersScreenState extends State<ServiceWorkersScreen> {
  final List<Map<String, dynamic>> _workers = [
    {
      'name': 'Ahmed Khan',
      'rating': 4.8,
      'experience': '5 years',
      'contact': '+92 300 1234567',
      'location': 'Gulshan-e-Iqbal',
      'specialization': 'Residential & Commercial',
      'image': '👨‍🔧',
    },
    {
      'name': 'Muhammad Ali',
      'rating': 4.6,
      'experience': '3 years',
      'contact': '+92 301 2345678',
      'location': 'Defence',
      'specialization': 'Emergency Repairs',
      'image': '👨‍🔧',
    },
    {
      'name': 'Hassan Raza',
      'rating': 4.9,
      'experience': '7 years',
      'contact': '+92 302 3456789',
      'location': 'Clifton',
      'specialization': 'Industrial & Home',
      'image': '👨‍🔧',
    },
    {
      'name': 'Usman Ahmed',
      'rating': 4.5,
      'experience': '4 years',
      'contact': '+92 303 4567890',
      'location': 'North Nazimabad',
      'specialization': 'All Types',
      'image': '👨‍🔧',
    },
    {
      'name': 'Bilal Hassan',
      'rating': 4.7,
      'experience': '6 years',
      'contact': '+92 304 5678901',
      'location': 'Malir',
      'specialization': 'Modern Systems',
      'image': '👨‍🔧',
    },
  ];

  void _contactWorker(String workerName, String contact) {
    customSnackBar(
      'Contact Worker',
      'Calling $workerName at $contact',
      context: context,
    );
    // TODO: Implement actual calling functionality
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
          title: Column(
            children: [
              Text(
                widget.serviceName,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.045,
                ),
              ),
              Text(
                widget.city,
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Header Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.05),
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: const Color(0xFF4CAF50),
                      size: screenWidth * 0.06,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_workers.length} Workers Available',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                          Text(
                            'Tap to contact any worker',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4CAF50).withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Workers List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  itemCount: _workers.length,
                  itemBuilder: (context, index) {
                    final worker = _workers[index];
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF4CAF50).withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Worker Header
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.15,
                                  height: screenWidth * 0.15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      worker['image'],
                                      style: TextStyle(fontSize: screenWidth * 0.08),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        worker['name'],
                                        style: GoogleFonts.poppins(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF4CAF50),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: screenWidth * 0.04,
                                          ),
                                          SizedBox(width: screenWidth * 0.01),
                                          Text(
                                            '${worker['rating']}',
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.02),
                                          Text(
                                            '• ${worker['experience']}',
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: screenHeight * 0.02),
                            
                            // Worker Details
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: const Color(0xFF4CAF50).withOpacity(0.7),
                                  size: screenWidth * 0.04,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  worker['location'],
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: screenHeight * 0.01),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  color: const Color(0xFF4CAF50).withOpacity(0.7),
                                  size: screenWidth * 0.04,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  worker['specialization'],
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: screenHeight * 0.02),
                            
                            // Contact Button
                            Container(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => _contactWorker(worker['name'], worker['contact']),
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: screenWidth * 0.04,
                                ),
                                label: Text(
                                  'Contact ${worker['name']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4CAF50),
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 