import 'package:flutter/material.dart';

class CustomElevatedButtonIcon extends StatefulWidget {
  final String title;
  final Widget icon;
  final Function() onPressed;
  const CustomElevatedButtonIcon(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  State<CustomElevatedButtonIcon> createState() =>
      _CustomElevatedButtonIconState();
}

class _CustomElevatedButtonIconState extends State<CustomElevatedButtonIcon> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                primary: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await widget.onPressed();
              } catch (e) {}
              setState(() {
                _isLoading = false;
              });
            },
            icon: _isLoading
                ? const SizedBox(
                    width: 32, height: 32, child: CircularProgressIndicator())
                : widget.icon,
            label: Text(widget.title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600))));
  }
}
