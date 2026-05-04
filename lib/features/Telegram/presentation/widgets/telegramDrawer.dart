import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme/themeBloc.dart';
import '../bloc/theme/themeEvent.dart';

class TelegramDrawer extends StatelessWidget {
  const TelegramDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("H", style: TextStyle(fontSize: 24)),
            ),
            accountName: const Text(
              "Hadel Brmo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("+963 951612591"),
            otherAccountsPictures: [

             ThemeSwitcher(
              builder: (context) {
              return IconButton(
              icon: Icon(
              Theme.of(context).brightness == Brightness.light
              ? Icons.dark_mode
                  : Icons.light_mode,
              ),
              onPressed: () {
              ThemeData newTheme = Theme.of(context).brightness == Brightness.light
              ? ThemeData.dark()
                  : ThemeData.light();

              ThemeSwitcher.of(context).changeTheme(
              theme: newTheme,
              );

              },
              );
              },
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(Icons.group_outlined, "New Group"),
                _drawerItem(Icons.person_outline, "Contacts"),
                _drawerItem(Icons.call_outlined, "Calls"),
                _drawerItem(Icons.bookmark_border, "Saved Messages"),
                _drawerItem(Icons.settings_outlined, "Settings"),
                const Divider(),
                _drawerItem(Icons.person_add_alt_outlined, "Invite Friends"),
                _drawerItem(Icons.help_outline, "Telegram Features"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: () {
      },
    );
  }
}