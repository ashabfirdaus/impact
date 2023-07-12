import 'package:flutter/material.dart';

class RowData extends StatelessWidget {
  final String title;
  final String? value;
  final String? subtitle;
  final VoidCallback? action;
  final Widget? wvalue;

  const RowData({
    super.key,
    required this.title,
    this.value,
    this.subtitle,
    this.action,
    this.wvalue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ]
              ],
            ),
          ),
          if (value != null)
            SizedBox(
              child: Text(
                value!,
                style: const TextStyle(fontSize: 15),
              ),
            )
          else if (wvalue != null)
            SizedBox(
              child: wvalue!,
            )
          else
            Container()
        ]),
      ),
    );
  }
}
