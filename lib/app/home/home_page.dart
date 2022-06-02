import 'package:flutter/material.dart';
import 'package:muraita_apps/app/account/account_page.dart';
import 'package:muraita_apps/app/home/listings/listings_page.dart';
import 'package:muraita_apps/app/home/products_page.dart';
import 'package:muraita_apps/app/home/tab_item.dart';
import 'cupertino_home_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.neighborhood: GlobalKey<NavigatorState>(),
    TabItem.chats: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    ///TODO: change listingsPage to products page,
    return {
      TabItem.home: (_) => ProductsPage(),
      TabItem.neighborhood: (_) => Container(),
      TabItem.chats: (_) => Container(),
      TabItem.account: (_) => const AccountPage(),
    };
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectedTab: _selectTab,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
