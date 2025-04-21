import 'package:auto_route/auto_route.dart';
import 'package:sample_app/Controller/AppRoot/app_root.dart';
import 'package:sample_app/Controller/Blank/blank.dart';
import 'package:sample_app/Controller/Cart/cart.dart';
import 'package:sample_app/Controller/Cart/cart_detail.dart';
import 'package:sample_app/Controller/Home/home.dart';
import 'package:sample_app/Controller/OpenReport/open_report.dart';
import 'package:sample_app/Controller/Receipt/receipt.dart';

// ##### NEED TO RUN TO GENERATE ROUTES ######
// flutter packages pub run build_runner watch --delete-conflicting-outputs
// ###########################################

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AppRoot, initial: true),
    AutoRoute(page: Home),
    AutoRoute(page: Receipt),
    AutoRoute(page: OpenReport),
    AutoRoute(page: Cart),
    AutoRoute(page: Blank),
    AutoRoute(page: CartDetail)
  ],
)
class $AppRouter {}
