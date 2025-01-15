import 'package:flutter/material.dart';

Widget buildBody() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: 32,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'Item $index',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
