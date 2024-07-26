import 'package:flutter/material.dart';
import 'package:servease_cap/home_screens/navigationbar.dart';
import 'package:servease_cap/home_screens/searchbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0; // Default to first tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'uber', // Set your custom font family
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
            color: Colors.black), // Change the app bar icon color to black
      ),
      body: Column(
        children: [
          SearchBar1(
            controller: searchController,
            onChanged: (value) {
              // Handle search functionality here
            },
          ),
          // You can add more widgets here if needed
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
