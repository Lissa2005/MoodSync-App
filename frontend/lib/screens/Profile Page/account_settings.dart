import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class AccountSettingsScreen extends StatefulWidget {
  final String? mood;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;
  
  const AccountSettingsScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  //default value
  late Color primaryColor;
  late Color secondaryColor;
  late Color accentColor;
  late String mood;
  // Variables to store user settings
  bool isDarkMode = false;
  bool isAutoPlay = true;
  String selectedLanguage = 'English';
  String downloadQuality = 'High';
  int cacheSize = 245;

  // Lists for dropdown options
  final List<String> languages = ['English', 'Spanish', 'French', 'German', 'Japanese', 'Chinese'];
  final List<String> qualities = ['Low', 'Medium', 'High', 'Very High'];

  @override
  void initState() {
    super.initState();
    // Initialize with provided values or defaults
    primaryColor = widget.primaryColor ?? Colors.purple;
    secondaryColor = widget.secondaryColor ?? Colors.deepPurple;
    accentColor = widget.accentColor ?? Colors.amber;
    mood = widget.mood ?? 'happy';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF8F0FF), 
              const Color(0xFFF0E6FF), 
              const Color(0xFFE8D9FF), 
              primaryColor.withOpacity(0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: secondaryColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Time display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      '10:30',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //general settings section
                      Text(
                        'General',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:primaryColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Change Password
                            ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.lock_outline, color: primaryColor, size: 20),
                              ),
                              title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.w500)),
                              trailing: Icon(Icons.arrow_forward_ios, size: 14, color: primaryColor),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Change Password coming soon!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                            
                            const Divider(indent: 60, endIndent: 20),
                            
                            // language selection
                            ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.language, color: primaryColor, size: 20),
                              ),
                              title: const Text('Language', style: TextStyle(fontWeight: FontWeight.w500)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(selectedLanguage, style: TextStyle(color: secondaryColor)),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 14, color: primaryColor),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Select Language'),
                                      content: SizedBox(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: languages.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(languages[index]),
                                              trailing: selectedLanguage == languages[index]
                                                  ? Icon(Icons.check, color: widget.primaryColor)
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  selectedLanguage = languages[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      //preferences section
                      Text(
                        'Preferences',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Dark Mode Switch
                            SwitchListTile(
                              secondary: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.dark_mode_outlined, color: primaryColor, size: 20),
                              ),
                              title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
                              value: isDarkMode,
                              onChanged: (bool value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            
                            const Divider(indent: 60, endIndent: 20),
                            
                            // auto-play switch
                            SwitchListTile(
                              secondary: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.play_circle_outline, color:primaryColor, size: 20),
                              ),
                              title: const Text('Auto-Play', style: TextStyle(fontWeight: FontWeight.w500)),
                              value: isAutoPlay,
                              onChanged: (bool value) {
                                setState(() {
                                  isAutoPlay = value;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // data and storage section
                      Text(
                        'Data & Storage',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            
                            //clear cache option
                            ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.clean_hands, color: primaryColor, size: 20),
                              ),
                              title: const Text('Clear Cache', style: TextStyle(fontWeight: FontWeight.w500)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('$cacheSize MB', style: TextStyle(color: secondaryColor)),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 14, color: primaryColor),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Clear Cache'),
                                      content: Text('Clear $cacheSize MB of cached data?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              cacheSize = 0;
                                            });
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text('Cache cleared successfully'),
                                                backgroundColor: widget.primaryColor,
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: widget.primaryColor,
                                          ),
                                          child: const Text('Clear'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            
                            const Divider(indent: 60, endIndent: 20),
                            
                            //download quality selection
                            ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.download, color: primaryColor, size: 20),
                              ),
                              title: const Text('Download Quality', style: TextStyle(fontWeight: FontWeight.w500)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(downloadQuality, style: TextStyle(color: secondaryColor)),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 14, color: primaryColor),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Download Quality'),
                                      content: SizedBox(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: qualities.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(qualities[index]),
                                              trailing: downloadQuality == qualities[index]
                                                  ? Icon(Icons.check, color: primaryColor)
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  downloadQuality = qualities[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // connected accounts section
                      Text(
                        'Connected Accounts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.music_note, color: primaryColor, size: 20),
                          ),
                          title: const Text('YouTube Music', style: TextStyle(fontWeight: FontWeight.w500)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Connected',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios, size: 14, color: widget.primaryColor),
                            ],
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('YouTube Music settings coming soon!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        selectedColor: primaryColor,
        onTap: (index) {
      
        },
      ),
    );
  }
}