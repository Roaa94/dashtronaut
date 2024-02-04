import 'package:flutter/material.dart';

class AppDrawerButton extends StatelessWidget {
  const AppDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        minimumSize: const Size(50, 45),
        fixedSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(width: 2, color: Colors.white),
        ),
      ),
      child: const Icon(Icons.menu),
    );
  }
}
