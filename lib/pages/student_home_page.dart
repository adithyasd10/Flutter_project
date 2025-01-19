import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

class StudentHomePage extends StatelessWidget {
  final List<Map<String, String>> groups = []; // List of groups

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Profile Section
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'lib/images/profile.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Student',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Guide Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Guide:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildHelpCard(
                  'Join Groups with a Link',
                  'Students can join a group using a link provided by the teacher.',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Group Section for Students
          Expanded(child: _buildGroupsSection()),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        height: 75,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: GNav(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: Colors.blue,
          color: Colors.black,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.white,
          gap: 8,
          tabs: [
            GButton(
              icon: Icons.link,
              text: "Join Group",
              onPressed: () {
                // Call the function to handle group joining
                _joinGroup(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Help Card Widget
  Widget _buildHelpCard(String title, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Lottie.asset(
                'assets/animations/app_guide.json',
                fit: BoxFit.cover,
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Groups Section for Students
  Widget _buildGroupsSection() {
    return _buildGroupList('Join Groups', groups.isEmpty);
  }

  // Group List Builder
  Widget _buildGroupList(String title, bool isEmpty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          if (isEmpty)
            const Center(
              child: Text(
                'No Groups Available',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          if (!isEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return _buildGroupCard(group);
                },
              ),
            ),
        ],
      ),
    );
  }

  // Group Card for Students
  Widget _buildGroupCard(Map<String, String> group) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.group, size: 40, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              group['name']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              group['description']!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Join Group Dialog
  void _joinGroup(BuildContext context) {
    // Show a dialog to input group link
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Join a Group"),
        content: TextField(
          decoration: const InputDecoration(hintText: "Enter group link"),
          onChanged: (value) {
            // Handle the link input
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle joining group logic (e.g., add to group list or validate the link)
              Navigator.pop(context);
            },
            child: const Text("Join"),
          ),
        ],
      ),
    );
  }
}
