import 'package:flutter/material.dart';

Widget buildDrawerItem(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String route,
    }) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
  );
}
