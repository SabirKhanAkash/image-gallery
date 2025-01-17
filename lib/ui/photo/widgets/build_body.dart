import 'package:flutter/material.dart';

Widget buildBody(
    TextEditingController userNameController, TextEditingController passwordController) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
              controller: userNameController,
              textAlign: TextAlign.start,
              maxLines: 1,
              maxLength: 20,
              keyboardType: TextInputType.name),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
