import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use http://10.0.2.2:8080 for Android Emulator to talk to your local Java server
  static const String baseUrl = 'http://10.0.2.2:8080';

  // --- AUTHENTICATION ---
  
  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Login failed: ${response.body}');
  }

  Future<void> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
    if (response.statusCode != 200) throw Exception('Failed to send OTP');
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );
    return response.statusCode == 200;
  }

  Future<void> register(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    if (response.statusCode != 201) throw Exception('Registration failed');
  }

  // --- HOSTELS ---

  Future<List<dynamic>> getHostels() async {
    final response = await http.get(Uri.parse('$baseUrl/hostels'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load hostels');
  }

  Future<void> addHostel(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/hostels'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add hostel');
  }

  // --- FLOORS, ROOMS, BEDS ---

  Future<List<dynamic>> getFloors(String hostelId) async {
    final response = await http.get(Uri.parse('$baseUrl/hostels/$hostelId/floors'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load floors');
  }

  Future<void> addFloor(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/floors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add floor');
  }

  Future<List<dynamic>> getRooms(String floorId) async {
    final response = await http.get(Uri.parse('$baseUrl/floors/$floorId/rooms'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load rooms');
  }

  Future<void> addRoom(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rooms'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add room');
  }

  Future<List<dynamic>> getBeds(String roomId) async {
    final response = await http.get(Uri.parse('$baseUrl/rooms/$roomId/beds'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load beds');
  }

  Future<void> addBed(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/beds'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add bed');
  }

  // --- RESIDENTS ---

  Future<List<dynamic>> getResidents() async {
    final response = await http.get(Uri.parse('$baseUrl/residents'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load residents');
  }

  Future<void> addResident(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/residents'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add resident');
  }

  // --- PAYMENTS & EXPENDITURE ---

  Future<List<dynamic>> getPayments() async {
    final response = await http.get(Uri.parse('$baseUrl/payments'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load payments');
  }

  Future<void> addPayment(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add payment');
  }

  Future<List<dynamic>> getExpenditures() async {
    final response = await http.get(Uri.parse('$baseUrl/expenditures'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load expenditures');
  }

  Future<void> addExpenditure(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenditures'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 201) throw Exception('Failed to add expenditure');
  }
}
