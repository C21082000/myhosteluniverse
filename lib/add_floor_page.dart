import 'package:flutter/material.dart';

class AddFloorPage extends StatefulWidget {
  const AddFloorPage({super.key});

  @override
  State<AddFloorPage> createState() => _AddFloorPageState();
}

class _AddFloorPageState extends State<AddFloorPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedHostel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Floor"),
        backgroundColor:   Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Hostel", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                hint: const Text("Choose Hostel"),
                items: ["Sardar Vallabhbhai Patel", "Vikram Sarabhai"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedHostel = value),
                validator: (value) => value == null ? "Please select a hostel" : null,
              ),
              const SizedBox(height: 20),
              const Text("Floor Number / Name", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "e.g. 1st Floor or Floor 1",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) => value!.isEmpty ? "Please enter floor name" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple ,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Floor added successfully")),
                      );
                    }
                  },
                  child: const Text("Add Floor"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
