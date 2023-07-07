import 'package:flutter/material.dart';

class SalesDetail extends StatefulWidget {
  final Map content;

  const SalesDetail({
    super.key,
    required this.content,
  });

  @override
  State<SalesDetail> createState() => _SalesDetailState();
}

class _SalesDetailState extends State<SalesDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
