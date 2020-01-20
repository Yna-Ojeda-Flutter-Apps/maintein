import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) async {
    var key = route.settings.name + ' screen';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if ( prefs.containsKey(key) ) {
      int value = prefs.getInt(key) + 1;
      prefs.setInt(key, value);
      debugPrint(route.settings.name + ' ' + value.toString());
    } else {
      prefs.setInt(key, 1);
      debugPrint('first access: ' + route.settings.name + ' ' + prefs.getInt(key).toString());
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    if ( route is PageRoute ) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    // TODO: implement didReplace
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if ( newRoute is PageRoute ) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if ( (previousRoute is PageRoute) && (route is PageRoute) ) {
      _sendScreenView(previousRoute);
    }
  }
}

