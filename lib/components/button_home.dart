import 'package:flutter/material.dart';

class ButtonHome extends StatefulWidget {
  final Image icon;
  final String label;
  final Function action;
  final double width;

  const ButtonHome(
      {Key? key,
      required this.icon,
      required this.label,
      required this.action,
      required this.width})
      : super(key: key);

  @override
  State<ButtonHome> createState() => _ButtonHomeState();
}

class _ButtonHomeState extends State<ButtonHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      child: TextButton(
        onPressed: () => widget.action(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(height: 5.0),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
