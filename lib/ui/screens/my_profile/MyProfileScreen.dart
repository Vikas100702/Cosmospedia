import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import 'FaqScreen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // Mock user data - in a real app, this would come from your state management
    final user = {
      'name': 'Alex Cosmos',
      'email': 'alex@cosmospedia.com',
      'initials': 'AC',
    };

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.3,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.transparentColor,
        appBar: customAppBar(
          scaffoldKey: scaffoldKey,
          context: context,
          titleWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'My Profile',
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildUserHeader(context, user),
              const SizedBox(height: 24),
              _buildProfileOptionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context, Map<String, dynamic> user) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[900]!.withOpacity(0.7),
              Colors.purple[900]!.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[700]!.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            // Avatar with cosmic background and gradient border
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue[400]!,
                    Colors.purple[500]!,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue[400]!.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/avatar_bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      user['initials'],
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // User info
            Text(
              user['name'],
              style: theme.textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 0.5,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user['email'],
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOptionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blue[700]!, Colors.blue[500]!],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Account Settings",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),

        // Account Settings
        _buildProfileOptionCard(
          context,
          title: "Name",
          subtitle: "Edit your display name",
          icon: Icons.person,
          gradientColors: [Colors.blue[700]!, Colors.cyan[400]!],
          onTap: () => _handleNameEdit(context),
        ),

        _buildProfileOptionCard(
          context,
          title: "Mail",
          subtitle: "Update your email address",
          icon: Icons.mail,
          gradientColors: [Colors.blue[700]!, Colors.cyan[400]!],
          onTap: () => _handleMailEdit(context),
        ),

        _buildProfileOptionCard(
          context,
          title: "Change Password",
          subtitle: "Update your security credentials",
          icon: Icons.lock,
          gradientColors: [Colors.blue[700]!, Colors.cyan[400]!],
          onTap: () => _handlePasswordChange(context),
        ),

        const SizedBox(height: 24),

        // Support Section
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple[700]!, Colors.purple[500]!],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Help & Support",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),

        _buildProfileOptionCard(
          context,
          title: "Queries",
          subtitle: "Ask us anything about Cosmospedia",
          icon: Icons.help,
          gradientColors: [Colors.purple[700]!, Colors.deepPurple[400]!],
          onTap: () => _showComingSoonDialog(context, "Queries"),
        ),

        _buildProfileOptionCard(
          context,
          title: "Contact Us",
          subtitle: "Get in touch with our support team",
          icon: Icons.support_agent,
          gradientColors: [Colors.purple[700]!, Colors.deepPurple[400]!],
          onTap: () => _showComingSoonDialog(context, "Contact Us"),
        ),

        _buildProfileOptionCard(
          context,
          title: "FAQs",
          subtitle: "Find answers to common questions",
          icon: Icons.question_answer,
          gradientColors: [Colors.purple[700]!, Colors.deepPurple[400]!],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FaqScreen(),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Legal Section
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.teal[700]!, Colors.teal[500]!],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Legal & Privacy",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),

        _buildProfileOptionCard(
          context,
          title: "Terms & Conditions",
          subtitle: "Read our terms of service",
          icon: Icons.gavel,
          gradientColors: [Colors.teal[700]!, Colors.green[500]!],
          onTap: () => _showComingSoonDialog(context, "Terms & Conditions"),
        ),

        _buildProfileOptionCard(
          context,
          title: "Privacy Policy",
          subtitle: "How we handle your data",
          icon: Icons.privacy_tip,
          gradientColors: [Colors.teal[700]!, Colors.green[500]!],
          onTap: () => _showComingSoonDialog(context, "Privacy Policy"),
        ),

        const SizedBox(height: 32),

        // Logout button
        Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red[700]!, Colors.red[400]!],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.red[700]!.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => _handleLogout(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.logout),
              label: const Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildProfileOptionCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required List<Color> gradientColors,
        required VoidCallback onTap,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          feature,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          "This feature is coming soon to Cosmospedia!",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue[300]),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNameEdit(BuildContext context) {
    final controller = TextEditingController(text: "Alex Cosmos");
    _showEditDialog(context, "Edit Name", "Update your display name", controller);
  }

  void _handleMailEdit(BuildContext context) {
    final controller = TextEditingController(text: "alex@cosmospedia.com");
    _showEditDialog(context, "Edit Email", "Update your email address", controller);
  }

  void _handlePasswordChange(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Current password",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "New password",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Confirm new password",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.blue[300]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password updated successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
            ),
            child: const Text("Update Password",
              style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context,
      String title,
      String description,
      TextEditingController controller
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Enter new value",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.blue[300]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${title.split(' ')[1]} updated successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
            ),
            child: const Text("Save",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Log Out",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Are you sure you want to log out of your account?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.blue[300]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In a real app, you would navigate to login screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully"),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
            ),
            child: const Text("Log Out",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}