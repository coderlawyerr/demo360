import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          MediaQuery.of(context).size.width / 1, // Ekranın 3'te biri genişlikte
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white), // İkon rengi beyaz
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Buton rengi mavi
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Köşe yuvarlama değeri azaltıldı
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
