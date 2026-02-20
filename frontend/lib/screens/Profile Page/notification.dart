import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class NotificationScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  
  const NotificationScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // push notification settings
  bool pushNewMusic = true;
  bool pushCommunityStories = true;
  bool pushMoodReminders = true;
  
  // email notification settings
  bool emailWeeklySummary = true;
  bool emailPromotions = false;
  
  // sound & vibration settings
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  String selectedSound = 'Default';
  
  final List<String> soundOptions = ['Default', 'Chime', 'Bell', 'Soft', 'None'];

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
              widget.primaryColor.withOpacity(0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // custom app bar with back button and title
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
                      color: widget.primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: widget.secondaryColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Notifications',
                          style: TextStyle(
                            color: widget.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    // time
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 5),
                      child: Row(
                        children: [
                          Text(
                            '10:30',
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.secondaryColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // main content with notification settings
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // push notifications section
                      Text(
                        'Push Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      _buildNotificationCard(
                        children: [
                          _buildSwitchTile(
                            icon: Icons.music_note,
                            title: 'New Music',
                            subtitle: 'Get notified about new releases',
                            value: pushNewMusic,
                            onChanged: (value) {
                              setState(() {
                                pushNewMusic = value;
                              });
                            },
                          ),
                          
                          _buildDivider(),
                          
                          _buildSwitchTile(
                            icon: Icons.people,
                            title: 'Community Stories',
                            subtitle: 'New stories from your community',
                            value: pushCommunityStories,
                            onChanged: (value) {
                              setState(() {
                                pushCommunityStories = value;
                              });
                            },
                          ),
                          
                          _buildDivider(),
                          
                          _buildSwitchTile(
                            icon: Icons.notifications_active,
                            title: 'Mood Reminders',
                            subtitle: 'Daily mood check-in reminders',
                            value: pushMoodReminders,
                            onChanged: (value) {
                              setState(() {
                                pushMoodReminders = value;
                              });
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // email notifications section
                      Text(
                        'Email Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      _buildNotificationCard(
                        children: [
                          _buildSwitchTile(
                            icon: Icons.calendar_today,
                            title: 'Weekly Summary',
                            subtitle: 'Your weekly music stats',
                            value: emailWeeklySummary,
                            onChanged: (value) {
                              setState(() {
                                emailWeeklySummary = value;
                              });
                            },
                          ),
                          
                          _buildDivider(),
                          
                          _buildSwitchTile(
                            icon: Icons.local_offer,
                            title: 'Promotions',
                            subtitle: 'Special offers and updates',
                            value: emailPromotions,
                            onChanged: (value) {
                              setState(() {
                                emailPromotions = value;
                              });
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // sound & vibration section
                      Text(
                        'Sound & Vibration',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      _buildNotificationCard(
                        children: [

                          // notification sound 
                          ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: widget.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.volume_up, color: widget.primaryColor, size: 20),
                            ),
                            title: const Text('Notification Sound', style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(selectedSound),
                            trailing: Icon(Icons.arrow_forward_ios, size: 14, color: widget.primaryColor),
                            onTap: () {
                              _showSoundDialog();
                            },
                          ),
                          
                          _buildDivider(),
                          
                          // vibration switch
                          SwitchListTile(
                            secondary: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: widget.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.vibration, color: widget.primaryColor, size: 20),
                            ),
                            title: const Text('Vibration', style: TextStyle(fontWeight: FontWeight.w500)),
                            value: vibrationEnabled,
                            onChanged: (bool value) {
                              setState(() {
                                vibrationEnabled = value;
                              });
                            },
                            activeColor: widget.primaryColor,
                          ),
                        ],
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
        selectedColor: widget.primaryColor,
        onTap: (index) {
          
        },
      ),
    );
  }

  // builder for notification cards
  Widget _buildNotificationCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // builder for switch list 
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: widget.primaryColor, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      value: value,
      onChanged: onChanged,
      activeColor: widget.primaryColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  // show select sound dialog
  void _showSoundDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Notification Sound'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: soundOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(soundOptions[index]),
                  trailing: selectedSound == soundOptions[index]
                      ? Icon(Icons.check, color: widget.primaryColor)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedSound = soundOptions[index];
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
  }

  // divider builder
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Divider(
        color: widget.primaryColor.withOpacity(0.2),
        height: 1,
      ),
    );
  }
}