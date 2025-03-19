import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: _textController.text,
              size: 200,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 40),
            buildTextField(context),
          ],
        ),
      ),
    );
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      controller: _textController,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: "Enter text to generate QR code",
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.done, size: 30),
          color: Theme.of(context).primaryColor,
          onPressed: () => setState(() {}),
        ),
      ),
    );
  }
}
