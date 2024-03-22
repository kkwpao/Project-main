import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:finalproject/user_provider.dart';

class CusProfile extends StatefulWidget {
  @override
  _CusProfileState createState() => _CusProfileState();
}

class _CusProfileState extends State<CusProfile> {
  late String name;
  late String lastName;
  late String phone;
  late String email;

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นใน initState

    // กำหนดค่าให้กับตัวแปรที่ใช้เก็บข้อมูล
    name = "";
    lastName = "";
    phone = "";
    email = "";
    fetchCusProfile();

    // เรียกเมธอดเพื่อดึงข้อมูลโปรไฟล์ผู้ใช้
  }

  Future<void> fetchCusProfile() async {
    // URL API ที่ต้องการเรียก (แทนที่ด้วย URL ของ API จริง)
    final url = Uri.parse('http://127.0.0.1/barber/showprofile.php');
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final response = await http.post(
        url,
        body: {'cus_id': userProvider.getCusId()},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> cusData = data['data'];

        // Use null-aware operators to handle null values
        String _name = cusData['cus_name'] ?? '';
        String _lastName = cusData['cus_lastname'] ?? '';
        String _phone = cusData['cus_phone'] ?? '';
        String _email = cusData['cus_email'] ?? '';

        setState(() {
          name = _name;
          lastName = _lastName;
          phone = _phone;
          email = _email;
        });
      } else {
        print('Unexpected data format');
      }
    } catch (error) {
      print('Error loading user profile: $error');
    }
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // รูปโปรไฟล์
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 58,
              backgroundColor: Color.fromARGB(255, 245, 123, 57), // สีพื้นหลังของวงกลม
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 100, // ขนาดไอคอน
                  color: Colors.white, // สีไอคอน
                ),
              ),
            ),

            // ข้อมูล
            const SizedBox(height: 20),
            itemProfile('Name', name, Icons.person),
            const SizedBox(height: 20),
            itemProfile('LastName', lastName, Icons.person),
            const SizedBox(height: 10),
            itemProfile('Phone', phone, Icons.phone),
            const SizedBox(height: 10),
            itemProfile('Email', email, Icons.mail),
            const SizedBox(
              height: 20,
            ),

            // ปุ่ม
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit_profile');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
