import 'package:flutter/material.dart';
import 'package:impact_driver/services/global.dart';

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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: widget.icon,
            ),
            Container(
              width: 92,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: GlobalConfig.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
