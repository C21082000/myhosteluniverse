import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResidentsListPage extends StatefulWidget {
  const ResidentsListPage({super.key});

  @override
  State<ResidentsListPage> createState() => _ResidentsListPageState();
}

class _ResidentsListPageState extends State<ResidentsListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('Could not launch $launchUri');
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final String url = "https://wa.me/91$phoneNumber"; 
    final Uri launchUri = Uri.parse(url);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $launchUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Residents"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Inactive"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildResidentList(isActive: true),
          _buildResidentList(isActive: false),
        ],
      ),
    );
  }

  Widget _buildResidentList({required bool isActive}) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (context, index) {
        final names = ["Chenna Kesavulu", "Ravi Teja", "John Sumanth", "Patricia Williams", "Robert Brown", "Jennifer Jones"];
        final ids = ["R001", "R002", "R003", "R004", "R005", "R006"];
        final phone = "7993605635";
        
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(names[index % names.length], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Id: ${ids[index % ids.length]}", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      Text(phone, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      Text("Floor: ${index < 3 ? 1 : 2} | Room: ${100 + index + 1}", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      const Text("Joined: 01 Jan 2024", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _makeCall(phone), 
                      icon: const Icon(Icons.phone, color: Color(0xFF1565C0)),
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    IconButton(
                      onPressed: () => _launchWhatsApp(phone), 
                      icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24),
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
