import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/custom_snackbar.dart';
import 'service_workers_screen.dart';

class ExplorerDashboardScreen extends StatefulWidget {
  final String userName;
  
  const ExplorerDashboardScreen({
    super.key,
    required this.userName,
  });

  @override
  State<ExplorerDashboardScreen> createState() => _ExplorerDashboardScreenState();
}

class _ExplorerDashboardScreenState extends State<ExplorerDashboardScreen> {
  String _selectedCity = 'Karachi';
  final List<String> _cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
    'Quetta',
    'Sialkot',
    'Gujranwala',
  ];

  final List<Map<String, dynamic>> _serviceCategories = [
    {
      'name': 'Plumber',
      'icon': Icons.plumbing,
      'description': 'Find skilled plumbers for all your plumbing needs',
      'color': Colors.black,
    },
    {
      'name': 'Electrician',
      'icon': Icons.electrical_services,
      'description': 'Professional electricians for electrical work',
      'color': Color(0xFFFF9800),
    },
    {
      'name': 'Carpenter',
      'icon': Icons.handyman,
      'description': 'Expert carpenters for woodwork and repairs',
      'color': Color(0xFF795548),
    },
    {
      'name': 'Painter',
      'icon': Icons.brush,
      'description': 'Quality painters for interior and exterior work',
      'color': Color(0xFF9C27B0),
    },
    {
      'name': 'Cleaner',
      'icon': Icons.cleaning_services,
      'description': 'Professional cleaning services',
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'AC Technician',
      'icon': Icons.ac_unit,
      'description': 'AC installation, repair and maintenance',
      'color': Color(0xFF00BCD4),
    },
    {
      'name': 'Mechanic',
      'icon': Icons.build,
      'description': 'Automotive repair and maintenance',
      'color': Color(0xFF607D8B),
    },
    {
      'name': 'Gardener',
      'icon': Icons.local_florist,
      'description': 'Landscaping and gardening services',
      'color': Color(0xFF8BC34A),
    },
  ];

  void _onServiceCardTap(String serviceName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceWorkersScreen(
          serviceName: serviceName,
          city: _selectedCity,
        ),
      ),
    );
  }

  void _showCityDialog() {
    final TextEditingController searchController = TextEditingController();
    List<String> filteredCities = List.from(_cities);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                 child: Column(
                   children: [
                     // Title
                     Text(
                       'Select City',
                       style: GoogleFonts.poppins(
                         fontSize: MediaQuery.of(context).size.width * 0.05,
                         fontWeight: FontWeight.w600,
                         color: const Color(0xFF4CAF50), // Light green
                       ),
                     ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                     
                     // Search Bar
                     Container(
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                           width: 2,
                         ),
                         borderRadius: BorderRadius.circular(15),
                       ),
                       child: TextField(
                         controller: searchController,
                         style: GoogleFonts.poppins(
                           fontSize: MediaQuery.of(context).size.width * 0.04,
                           fontWeight: FontWeight.w500,
                           color: const Color(0xFF4CAF50), // Light green
                         ),
                         decoration: InputDecoration(
                           hintText: 'Search cities...',
                           hintStyle: GoogleFonts.poppins(
                             fontSize: MediaQuery.of(context).size.width * 0.04,
                             fontWeight: FontWeight.w400,
                             color: const Color(0xFF4CAF50).withOpacity(0.5), // Light green
                           ),
                           border: InputBorder.none,
                           contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                           prefixIcon: Icon(
                             Icons.search,
                             color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                             size: MediaQuery.of(context).size.width * 0.05,
                           ),
                         ),
                         onChanged: (value) {
                           setState(() {
                             filteredCities = _cities
                                 .where((city) => city.toLowerCase().contains(value.toLowerCase()))
                                 .toList();
                           });
                         },
                       ),
                     ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                     
                     // Cities List
                     Expanded(
                       child: filteredCities.isEmpty
                           ? Center(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(
                                     Icons.search_off,
                                     size: MediaQuery.of(context).size.width * 0.1,
                                     color: const Color(0xFF4CAF50).withOpacity(0.5), // Light green
                                   ),
                                   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                   Text(
                                     'No cities found',
                                     style: GoogleFonts.poppins(
                                       fontSize: MediaQuery.of(context).size.width * 0.04,
                                       fontWeight: FontWeight.w600,
                                       color: const Color(0xFF4CAF50), // Light green
                                     ),
                                   ),
                                   SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                   Text(
                                     'Try a different search term',
                                     style: GoogleFonts.poppins(
                                       fontSize: MediaQuery.of(context).size.width * 0.035,
                                       fontWeight: FontWeight.w400,
                                       color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                                     ),
                                   ),
                                 ],
                               ),
                             )
                                                       : ListView.builder(
                                itemCount: filteredCities.length,
                                itemBuilder: (context, index) {
                                  final city = filteredCities[index];
                                  final isSelected = city == _selectedCity;
                                  
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedCity = city;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width * 0.04,
                                        vertical: MediaQuery.of(context).size.height * 0.015,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected 
                                            ? const Color(0xFF4CAF50).withOpacity(0.1) // Light green
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                                                                  border: Border.all(
                                            color: isSelected 
                                                ? const Color(0xFF4CAF50) // Light green
                                                : const Color(0xFF4CAF50).withOpacity(0.2), // Light green
                                            width: isSelected ? 2 : 1,
                                          ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: isSelected 
                                                ? const Color(0xFF4CAF50) // Light green
                                                : const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                                            size: MediaQuery.of(context).size.width * 0.05,
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                          Expanded(
                                            child: Text(
                                              city,
                                              style: GoogleFonts.poppins(
                                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                                color: isSelected 
                                                    ? const Color(0xFF4CAF50) // Light green
                                                    : const Color(0xFF4CAF50).withOpacity(0.8), // Light green
                                              ),
                                            ),
                                          ),
                                          if (isSelected)
                                            Icon(
                                              Icons.check_circle,
                                              color: const Color(0xFF4CAF50), // Light green
                                              size: MediaQuery.of(context).size.width * 0.05,
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                     ),
                     
                     // Cancel Button
                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                     TextButton(
                       onPressed: () => Navigator.pop(context),
                       child: Text(
                         'Cancel',
                         style: GoogleFonts.poppins(
                           fontSize: MediaQuery.of(context).size.width * 0.04,
                           fontWeight: FontWeight.w500,
                           color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             );
          },
        );
      },
    );
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
                       leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
           title: Column(
             children: [
               Text(
                 'Hi, ${widget.userName}',
                 style: GoogleFonts.poppins(
                   color: Colors.white,
                   fontWeight: FontWeight.w600,
                   fontSize: screenWidth * 0.045,
                 ),
               ),
               Text(
                 'Find Workers',
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                
                // City Selector
                GestureDetector(
                  onTap: _showCityDialog,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF4CAF50).withOpacity(0.3), // Light green
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                          size: screenWidth * 0.05,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Text(
                            _selectedCity,
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: const Color(0xFF4CAF50), // Light green
                          size: screenWidth * 0.06,
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.04),
                
                // Services Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenHeight * 0.02,
                    ),
                    itemCount: _serviceCategories.length,
                    itemBuilder: (context, index) {
                      final service = _serviceCategories[index];
                      
                      return GestureDetector(
                        onTap: () => _onServiceCardTap(service['name']),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: service['color'].withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: service['color'].withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  color: service['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  service['icon'],
                                  size: screenWidth * 0.08,
                                  color: service['color'],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                service['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4CAF50), // Light green
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                child: Text(
                                  service['description'],
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.025,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4CAF50).withOpacity(0.7), // Light green
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50), // Light green
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: const Color(0xFF4CAF50), // Light green
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, ${widget.userName}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Welcome back!',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 20),
                      
                      // Dashboard
                      _buildMenuItem(
                        icon: Icons.dashboard,
                        title: 'Dashboard',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        isSelected: true,
                      ),
                      
                      // Language
                      _buildMenuItem(
                        icon: Icons.language,
                        title: 'Language',
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('Select Language', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.language, color: Color(0xFF4CAF50)),
                                      title: Text('English', style: GoogleFonts.poppins()),
                                      onTap: () {
                                        Navigator.pop(context);
                                        // TODO: Set language to English
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.language, color: Color(0xFF4CAF50)),
                                      title: Text('Urdu', style: GoogleFonts.poppins()),
                                      onTap: () {
                                        Navigator.pop(context);
                                        // TODO: Set language to Urdu
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      
                      // Favorites
                      _buildMenuItem(
                        icon: Icons.favorite,
                        title: 'Favorites',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('Favorites', 'Favorites feature coming soon!', context: context);
                        },
                      ),
                      
                      // Notifications
                      _buildMenuItem(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('Notifications', 'Notifications feature coming soon!', context: context);
                        },
                      ),
                      
                      Divider(height: 30, thickness: 1, color: Colors.grey.withOpacity(0.3)),
                      
                      // Settings
                      _buildMenuItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('Settings', 'Settings feature coming soon!', context: context);
                        },
                      ),
                      
                      // Help & Support
                      _buildMenuItem(
                        icon: Icons.help,
                        title: 'Help & Support',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('Help & Support', 'Help & Support feature coming soon!', context: context);
                        },
                      ),
                      
                      // Terms & Conditions
                      _buildMenuItem(
                        icon: Icons.description,
                        title: 'Terms & Conditions',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('Terms & Conditions', 'Terms & Conditions feature coming soon!', context: context);
                        },
                      ),
                      
                      // Privacy Policy
                      _buildMenuItem(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Policy',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('Privacy Policy', 'Privacy Policy feature coming soon!', context: context);
                        },
                      ),
                      
                      // About Us
                      _buildMenuItem(
                        icon: Icons.info,
                        title: 'About Us',
                        onTap: () {
                          Navigator.pop(context);
                          customSnackBar('About Us', 'About Us feature coming soon!', context: context);
                        },
                      ),
                      
                      Divider(height: 30, thickness: 1, color: Colors.grey.withOpacity(0.3)),
                      
                      // Logout
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          Navigator.pop(context);
                          _showLogoutDialog();
                        },
                        isLogout: true,
                      ),
                      
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
    bool isLogout = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout 
              ? Colors.red 
              : isSelected 
                  ? const Color(0xFF4CAF50) // Light green
                  : Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isLogout 
                ? Colors.red 
                : isSelected 
                    ? const Color(0xFF4CAF50) // Light green
                    : Colors.grey[800],
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        trailing: isSelected 
            ? Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF4CAF50), // Light green
                size: 16,
              )
            : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: isSelected 
            ? const Color(0xFF4CAF50).withOpacity(0.1) // Light green
            : Colors.transparent,
      ),
    );
  }
  
  void _showLogoutDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SizedBox(
            height: screenHeight * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.logout,
                    color: const Color(0xFF4CAF50),
                    size: 80,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Are you sure',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color(0xFF4CAF50), // Light green
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'You want to logout?',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: const Color(0xFF4CAF50)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close sheet
                          Navigator.pushReplacementNamed(context, '/'); // Navigate to splash screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 