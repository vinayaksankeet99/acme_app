import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final Color color;
  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                primary: widget.color,
                textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            onPressed: widget.onPressed == null
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await widget.onPressed!();
                    } catch (e) {}
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: _isLoading
                ? const SizedBox(
                    width: 32, height: 32, child: CircularProgressIndicator())
                : Text(widget.title,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))));
  }
}
