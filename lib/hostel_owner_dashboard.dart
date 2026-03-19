import 'package:flutter/material.dart';
import 'login_page.dart';
import 'add_resident_page.dart';
import 'residents_list_page.dart';
import 'payments_page.dart';
import 'expenditure_page.dart';
import 'hostels_list_page.dart';
import 'floors_list_page.dart';
import 'rooms_list_page.dart';
import 'beds_list_page.dart';

class HostelOwnerDashboard extends StatelessWidget {
  const HostelOwnerDashboard({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out of your session?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _openPopup(BuildContext context, Widget page) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: page,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Monday, 23 Oct", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 16),
                  
                  // Action Grid
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [

                      _buildQuickAction(context, Icons.domain_outlined, "Hostels", const HostelsListPage()),
                      _buildQuickAction(context, Icons.layers_outlined, "Floors", const FloorsListPage()),
                      _buildQuickAction(context, Icons.meeting_room_outlined, "Rooms", const RoomsListPage()),
                      _buildQuickAction(context, Icons.single_bed_outlined, "Beds", const BedsListPage()),
                       _buildQuickAction(context, Icons.person_add_outlined, "Add Resident", const AddResidentPage()),
                      _buildQuickAction(context, Icons.people_outline, "Residents", const ResidentsListPage()),
                       _buildQuickAction(context, Icons.receipt_long_outlined, "Payments", const PaymentsPage()),
                      _buildQuickAction(context, Icons.add_circle_outline, "Expenditure", const ExpenditurePage()),
                       _buildQuickAction(context, Icons.bar_chart_outlined, "Reports", null),

                    ],
                  ),

                 ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(BuildContext context, String title, List<Widget> items, VoidCallback onViewAll, VoidCallback onAdd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            Row(
              children: [
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline, color: Colors.deepPurple, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: onViewAll,
                  child: const Text("View All", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {},
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.deepPurple, Color(0xFF8E24AA)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(radius: 37, backgroundImage: NetworkImage('https://i.pravatar.cc/300')),
                ),
                SizedBox(height: 15),
                Text("James Martin", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Hostel Owner & Admin", style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _drawerItem(Icons.person_outline, "Update Profile", () {}),
                _drawerItem(Icons.settings_outlined, "Settings", () {}),
                _drawerItem(Icons.description_outlined, "Terms & Conditions", () {}),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                _drawerItem(Icons.logout, "Log Out", () => _showLogoutDialog(context), color: Colors.redAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Widget? target) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (target != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => target));
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Icon(icon, color: Colors.deepPurple, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87), textAlign: TextAlign.center),
      ],
    );
  }



  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87, size: 24),
      title: Text(title, style: TextStyle(color: color ?? Colors.black87, fontSize: 15, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
