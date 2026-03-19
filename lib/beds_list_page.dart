import 'package:flutter/material.dart';
import 'add_bed_page.dart';

class BedsListPage extends StatefulWidget {
  const BedsListPage({super.key});

  @override
  State<BedsListPage> createState() => _BedsListPageState();
}

class _BedsListPageState extends State<BedsListPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";

  final List<Map<String, String>> _allBeds = List.generate(8, (index) => {
    "hostel": "Sardar Vallabhbhai Patel",
    "room": "Room 101",
    "number": "Bed ${index + 1}",
    "resident": index % 2 == 0 ? "Assigned to Chenna" : "Vacant",
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: AddBedPage(),
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
        hintText: "Search beds...",
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
    final filteredList = _allBeds.where((bed) {
      final query = _searchQuery.toLowerCase();
      return bed["number"]!.toLowerCase().contains(query) ||
             bed["resident"]!.toLowerCase().contains(query) ||
             bed["room"]!.toLowerCase().contains(query) ||
             bed["hostel"]!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text("Beds", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: _isSearching ? const BackButton() : null,
        actions: _buildActions(),
        elevation: 0,
      ),
      body: filteredList.isEmpty 
        ? const Center(child: Text("No beds found.", style: TextStyle(color: Colors.grey)))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final bed = filteredList[index];
              return _buildBedItem(
                hostel: bed["hostel"]!,
                room: bed["room"]!,
                number: bed["number"]!,
                resident: bed["resident"]!,
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

  Widget _buildBedItem({
    required String hostel,
    required String room,
    required String number,
    required String resident,
  }) {
    final bool isVacant = resident.toLowerCase() == "vacant";

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
              child: const Icon(Icons.single_bed, color: Colors.deepPurple, size: 28),
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
                        number,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isVacant ? Colors.green.shade100 : Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          isVacant ? "Vacant" : "Occupied",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isVacant ? Colors.green.shade900 : Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$room | $hostel",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: isVacant ? Colors.grey : Colors.deepPurple[400]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          resident,
                          style: TextStyle(
                            fontSize: 14,
                            color: isVacant ? Colors.grey[600] : Colors.black87,
                            fontWeight: isVacant ? FontWeight.normal : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
}
