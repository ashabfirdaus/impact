import 'package:impact_driver/layouts/pages/delivery.dart';
import '../layouts/pages/finished_material/index.dart';
import '../layouts/pages/auth/login.dart';
import '../layouts/pages/presence.dart';
import '../layouts/pages/purchase.dart';
import '../layouts/pages/row_material/index.dart';
import '../layouts/pages/sales.dart';
import '../layouts/pages/tabs.dart';
import '../layouts/splashscreen.dart';

class AppRoutes {
  static var route = {
    '/': (context) => const Splashscreen(),
    '/login': (context) => const Login(),
    '/tabs': (context) => const Tabs(),
    '/row-material-stock': (context) => const RowMaterial(),
    '/finished-material-stock': (context) => const FinishedMaterial(),
    '/presence': (context) => const Presence(),
    '/delivery': (context) => const Delivery(),
    '/sales': (context) => const Sales(),
    '/purchase': (context) => const Purchase(),
    // '/detail-transaction': (context) => DetailTransaction(
    //     content: ModalRoute.of(context)?.settings.arguments as Map),
    // '/accept-delivery': (context) => AcceptDelivery(
    //     content: ModalRoute.of(context)?.settings.arguments as Map),
    // '/preview-image': (context) =>
    //     PreviewImage(content: ModalRoute.of(context)?.settings.arguments as Map)
  };
}
