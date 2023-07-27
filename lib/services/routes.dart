import 'package:flutter/material.dart';
import 'package:impact_driver/layouts/pages/delivery/index.dart';
import 'package:impact_driver/layouts/pages/purchase/detail.dart';
import 'package:impact_driver/layouts/pages/row_material/detail.dart';
import 'package:impact_driver/layouts/pages/sales/detail.dart';
import '../layouts/pages/delivery/detail_transaction.dart';
import '../layouts/pages/finished_material/detail.dart';
import '../layouts/pages/finished_material/index.dart';
import '../layouts/pages/auth/login.dart';
import '../layouts/pages/presence.dart';
import '../layouts/pages/purchase/index.dart';
import '../layouts/pages/row_material/index.dart';
import '../layouts/pages/sales/index.dart';
import '../layouts/pages/tabs.dart';
import '../layouts/splashscreen.dart';

class AppRoutes {
  static var route = {
    '/': (context) => const Splashscreen(),
    '/login': (context) => const Login(),
    '/tabs': (context) => const Tabs(),
    '/row-material-stock': (context) => const RowMaterial(),
    '/row-material-detail': (context) => RowMaterialDetail(
        content: ModalRoute.of(context)?.settings.arguments as Map),
    '/finished-material-stock': (context) => const FinishedMaterial(),
    '/finished-material-detail': (context) => FinishedMaterialDetail(
        content: ModalRoute.of(context)?.settings.arguments as Map),
    '/presence': (context) => const Presence(),
    '/delivery': (context) => const Delivery(),
    '/sales': (context) => const Sales(),
    '/sales_detail': (context) =>
        SalesDetail(content: ModalRoute.of(context)?.settings.arguments as Map),
    '/purchase': (context) => const Purchase(),
    '/purchase_detail': (context) => PurchaseDetail(
        content: ModalRoute.of(context)?.settings.arguments as Map),
    '/detail-transaction': (context) => DetailTransaction(
        content: ModalRoute.of(context)?.settings.arguments as Map),
    // '/accept-delivery': (context) => AcceptDelivery(
    //     content: ModalRoute.of(context)?.settings.arguments as Map),
    // '/preview-image': (context) =>
    //     PreviewImage(content: ModalRoute.of(context)?.settings.arguments as Map)
  };
}
