import 'package:flutter/material.dart';

class RowDetail extends StatelessWidget {
  final String label;
  final String? value;
  final Color? color;
  final String type;

  const RowDetail({
    super.key,
    required this.label,
    this.value,
    this.color,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (type == 'list') ...[
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Text(label, style: const TextStyle(fontSize: 15)),
                ),
                Text(value!, style: const TextStyle(fontSize: 15))
              ],
            ),
          ),
        ] else if (type == 'header') ...[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color ?? Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ] else
          Container()
      ],
    );
  }
}
