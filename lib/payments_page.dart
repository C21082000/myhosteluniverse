import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> with SingleTickerProviderStateMixin {
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
    final String url = "https://wa.me/91$phoneNumber"; // Assuming Indian number (+91)
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
        title: const Text("Payments"),
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
            Tab(text: "Paid"),
            Tab(text: "Pending"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPaymentList(isPaid: true),
          _buildPaymentList(isPaid: false),
        ],
      ),
    );
  }

  Widget _buildPaymentList({required bool isPaid}) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 3,
      itemBuilder: (context, index) {
        final paidNames = ["John Doe", "Peter Jones"];
        final pendingNames = ["Jane Smith", "Mary Johnson", "Chris Lee"];
        final name = isPaid ? paidNames[index % paidNames.length] : pendingNames[index % pendingNames.length];
        final id = isPaid ? (index + 1) : (index + 2);
        final status = isPaid ? "Paid" : (index == 1 ? "Partial" : "Pending");
        final statusColor = isPaid ? Colors.green : (index == 1 ? Colors.orange : Colors.red);
        const phone = "7993605635";

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("Patient Id: $id", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                          Text("Room: ${100 + id}", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                          const Text("Joined: 01 Jan 2024", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                          Text("Amount: ${4500.0 + (index * 500)}", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                          Text("${isPaid ? 'Paid on' : 'Due on'}: 2024-07-25", style: const TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
                if (!isPaid) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _makeCall(phone), 
                        icon: const Icon(Icons.phone, color: Color(0xFF1565C0)),
                      ),
                      IconButton(
                        onPressed: () => _launchWhatsApp(phone), 
                        icon: const Icon(Icons.chat_bubble_outline, color: Colors.green),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
