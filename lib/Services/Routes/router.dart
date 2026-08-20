import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../Controller/AppRoot/app_root.dart';
import '../../Controller/Blank/blank.dart';
import '../../Controller/Cart/cart.dart';
import '../../Controller/Cart/cart_detail.dart';
import '../../Controller/Home/home.dart';
import '../../Controller/Receipt/receipt.dart';

part 'router.gr.dart';

// ##### NEED TO RUN TO GENERATE ROUTES ######
// flutter packages pub run build_runner watch --delete-conflicting-outputs
// ###########################################

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppRootRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ReceiptRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(page: BlankRoute.page),
        AutoRoute(page: CartDetailRoute.page),
      ];
}
