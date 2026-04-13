import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytasks/core/utils/app_colors/app_colors.dart';


class Getsearch extends StatelessWidget {
  const Getsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.grey),
                  hintText: "Search",
                  hintStyle:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}