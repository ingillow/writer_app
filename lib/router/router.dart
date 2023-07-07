import 'package:go_router/go_router.dart';
import 'package:writer_app/pages/home_page.dart';
import 'package:writer_app/pages/settings_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => MyHomePage(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => SettingsPage(),
    ),
    /*GoRoute(
        name: 'draft',
        path: '/draft',
        builder: (context, state) => DraftPage(*//*draftTextSaved: '', draftHeaderSaved: '', *//*))*/
  ],
);
