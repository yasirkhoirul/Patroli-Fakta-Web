import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  final Function() onclickstruktur;
  const Homescreen({super.key,required this.onclickstruktur});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: OutlinedButton(
            onPressed: onclickstruktur,
            child: const Text("ke struktur"),
          ),
        ),
      ),
    );
  }
}
