import 'package:flutter/material.dart';

class AddResidentPage extends StatefulWidget {
  const AddResidentPage({super.key});

  @override
  State<AddResidentPage> createState() => _AddResidentPageState();
}

class _AddResidentPageState extends State<AddResidentPage> {
  final _formKey = GlobalKey<FormState>();
  String _occupation = 'Student';
  String _idType = 'Aadhar';
  String _gender = 'Male';

  void _showImageSourceDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Upload $type", style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Choose an option to upload the $type."),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.photo_library, color: Colors.indigo),
                label: const Text("Gallery", style: TextStyle(color: Colors.indigo)),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.camera_alt, color: Colors.indigo),
                label: const Text("Camera", style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Resident"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Photo Section
                  Center(
                    child: GestureDetector(
                      onTap: () => _showImageSourceDialog("Profile Photo"),
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFEEEEEE),
                            child: Icon(Icons.person, size: 50, color: Colors.grey),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _sectionHeader("Personal Information"),
                  _buildTextField("Resident ID"),
                  Row(
                    children: [
                      Expanded(child: _buildTextField("First Name")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTextField("Last Name")),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Gender: ", style: TextStyle(color: Colors.grey)),
                      Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (v) => setState(() => _gender = v!),
                      ),
                      const Text("Male"),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (v) => setState(() => _gender = v!),
                      ),
                      const Text("Female"),
                    ],
                  ),
                  _buildDatePickerField("Date of Birth"),

                  const SizedBox(height: 24),
                  _sectionHeader("Allocation Details"),
                  _buildDropdownField("Select Hostel", ["Hostel A", "Hostel B", "Hostel C"], initialValue: "Hostel A"),
                  Row(
                    children: [
                      Expanded(child: _buildTextField("Floor No", keyboardType: TextInputType.number)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTextField("Room No", keyboardType: TextInputType.number)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTextField("Bed No", keyboardType: TextInputType.number)),
                    ],
                  ),

                  const SizedBox(height: 24),
                  _sectionHeader("ID Proof"),
                  _buildDropdownField("ID Proof Type", ["Aadhar", "PAN Card", "Voter ID"], initialValue: "Aadhar"),
                  _buildTextField("ID Proof Number"),
                  Row(
                    children: [
                      Expanded(child: _buildImageUploadBox("ID Front Side")),
                      const SizedBox(width: 16),
                      Expanded(child: _buildImageUploadBox("ID Back Side")),
                    ],
                  ),

                  const SizedBox(height: 24),
                  _sectionHeader("Contact & Occupation"),
                  _buildTextField("Phone Number", keyboardType: TextInputType.phone),
                  _buildTextField("Guardian Name & Relation"),
                  _buildTextField("Guardian Phone", keyboardType: TextInputType.phone),
                  
                  const SizedBox(height: 8),
                  const Text("Occupation", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Student',
                        groupValue: _occupation,
                        onChanged: (v) => setState(() => _occupation = v!),
                      ),
                      const Text("Student"),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: 'Employee',
                        groupValue: _occupation,
                        onChanged: (v) => setState(() => _occupation = v!),
                      ),
                      const Text("Employee"),
                    ],
                  ),
                  _buildTextField(_occupation == 'Student' ? "College Name" : "Company Name"),

                  const SizedBox(height: 24),
                  _sectionHeader("Financial Details"),
                  Row(
                    children: [
                      Expanded(child: _buildTextField("Monthly Rent", keyboardType: TextInputType.number, prefix: "₹")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTextField("Advance Amount", keyboardType: TextInputType.number, prefix: "₹")),
                    ],
                  ),

                  const SizedBox(height: 24),
                  _sectionHeader("Other Details"),
                  _buildTextField("Full Address", maxLines: 3),
                  _buildDatePickerField("Date of Joining"),
                  
                  const SizedBox(height: 100), // Extra space for FAB
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Resident Added Successfully')),
                  );
                  Navigator.pop(context);
                }
              },
              backgroundColor: Colors.deepPurple,
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text("Save Resident", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {TextInputType keyboardType = TextInputType.text, int maxLines = 1, String? prefix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefix,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_month),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, {String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) {},
      ),
    );
  }

  Widget _buildImageUploadBox(String title) {
    return GestureDetector(
      onTap: () => _showImageSourceDialog(title),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, color: Colors.grey[600]),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
