import 'package:aps/pages/comunity/EditComunityPostPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:aps/pages/comunity/AddComunityPostPage.dart';
import 'package:aps/pages/comunity/ComunityListPostPage.dart';
import 'package:aps/pages/comunity/ListUserComunityPostPage.dart';
import 'package:aps/pages/comunity/ViewComunityPostPage.dart';
import 'package:aps/pages/configure/EditConfigUserPage.dart';
import 'package:aps/pages/finance/AddFinancePage.dart';
import 'package:aps/pages/App.dart';
import 'package:aps/pages/BodyPageNavigator.dart';
import 'package:aps/pages/finance/EditFinancePage.dart';
import 'package:aps/pages/finance/FinancePage.dart';
import 'package:aps/pages/LoginPage.dart';
import 'package:aps/pages/SignUpPage.dart';
import 'package:aps/pages/finance/ViewFinancePage.dart';

void main() async {
  runApp(ModularApp(module: AppModule()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      navigatorKey: Modular.navigatorKey,
      // add Modular to manage the routing system
      onGenerateRoute: Modular.generateRoute,
      title: 'InvestJovem',
    );
  }
}

class AppModule extends MainModule {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => App()),
        ModularRouter('/login', child: (_, __) => LoginPage()),
        ModularRouter('/signup', child: (_, __) => SignUpPage()),
        ModularRouter('/comunitypost', child: (_, __) => ComunityPostPage()),
        ModularRouter('/bodypagenavigator/:page',
            child: (_, args) => BodyPageNavigator(page: args.params['page'])),
        ModularRouter('/addfinance', child: (_, __) => AddFinance()),
        ModularRouter('/financepage', child: (_, __) => FinancePage()),
        ModularRouter('/financeview/:uid',
            child: (_, args) => ViewFinancePage(uid: args.params['uid'])),
        ModularRouter('/financeedit/:uid',
            child: (_, args) => EditFinancePage(uid: args.params['uid'])),
        ModularRouter('/edituser/:uid',
            child: (_, args) => EditConfigUserPage(uid: args.params['uid'])),
        ModularRouter('/addcomunitypost',
            child: (_, __) => AddComunityPostPage()),
        ModularRouter('/comunitypostlist',
            child: (_, __) => ComunityPostPage()),
        ModularRouter('/viewcomunitypost/:uid',
            child: (_, args) => ViewComunityPostPage(uid: args.params['uid'])),
        ModularRouter('/editcomunitypost/:uid',
            child: (_, args) => EditComunityPostPage(uid: args.params['uid'])),
        ModularRouter('/listcomunityuserpost',
            child: (_, __) => ListComunityUserPost()),
      ];

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  Widget get bootstrap => MyApp();
}
