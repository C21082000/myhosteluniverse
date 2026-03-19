import 'package:flutter/material.dart';
import 'add_hostel_page.dart';

class HostelsListPage extends StatefulWidget {
  const HostelsListPage({super.key});

  @override
  State<HostelsListPage> createState() => _HostelsListPageState();
}

class _HostelsListPageState extends State<HostelsListPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";

  final List<Map<String, String>> _allHostels = List.generate(6, (index) => {
    "code": "H00${index + 1}",
    "name": "Hostel Name ${index + 1}",
    "phone1": "1234567890",
    "phone2": "0987654321",
    "address": "NIT Rourkela",
  });

  void _openAddPopup(BuildContext context) {
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
        child: const ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          child: AddHostelPage(),
        ),
      ),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchController.clear();
      _updateSearchQuery("");
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search hostels...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 18.0),
      onChanged: _updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _allHostels.where((hostel) {
      final query = _searchQuery.toLowerCase();
      return hostel["name"]!.toLowerCase().contains(query) ||
             hostel["code"]!.toLowerCase().contains(query) ||
             hostel["address"]!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text("Hostels", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: _isSearching ? const BackButton() : null,
        actions: _buildActions(),
        elevation: 0,
      ),
      body: filteredList.isEmpty 
        ? const Center(child: Text("No hostels found.", style: TextStyle(color: Colors.grey)))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final hostel = filteredList[index];
              return _buildHostelItem(
                name: hostel["name"]!,
                code: hostel["code"]!,
                phone1: hostel["phone1"]!,
                phone2: hostel["phone2"]!,
                address: hostel["address"]!,
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddPopup(context),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHostelItem({
    required String name,
    required String code,
    required String phone1,
    required String phone2,
    required String address,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.business, color: Colors.deepPurple, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$code - $name",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 8),
                  _buildDetailRow(Icons.phone_android, "P1: $phone1"),
                  const SizedBox(height: 4),
                  _buildDetailRow(Icons.phone, "P2: $phone2"),
                  const SizedBox(height: 4),
                  _buildDetailRow(Icons.location_on, address),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
