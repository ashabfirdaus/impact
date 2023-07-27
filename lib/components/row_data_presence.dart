import 'package:flutter/material.dart';

class RowDataPresence extends StatelessWidget {
  final String name;
  final String actualIn;
  final String actualOut;
  final VoidCallback? action;

  const RowDataPresence({
    super.key,
    required this.name,
    required this.actualOut,
    required this.actualIn,
    this.action,
  });

  String convertTime(stringTime) {
    if (stringTime == 'null') {
      return '-- : --';
    } else {
      return stringTime.substring(0, stringTime.length - 3);
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Masuk',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(convertTime(actualIn),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: VerticalDivider(color: Colors.grey),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Keluar',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        convertTime(actualOut),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
