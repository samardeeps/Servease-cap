import 'package:flutter/material.dart';

class SearchBar1 extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;

  const SearchBar1({
    required this.controller,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 233, 233),
                borderRadius: BorderRadius.circular(19.94),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 16),
                  contentPadding: EdgeInsets.all(6),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 233, 233),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/Adjust.png',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              // Handle filter button press
            },
          ),
        ],
      ),
    );
  }
}
