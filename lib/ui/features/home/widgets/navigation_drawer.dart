import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bayme/routing/routes.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                context.go(AppRoutes.dashboard);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.square),
              title: const Text("Products"),
              onTap: () {
                context.go(AppRoutes.products);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Inventory"),
              onTap: () {
                context.go(AppRoutes.inventory);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text("Orders"),
              onTap: () {
                context.go(AppRoutes.orders);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.percent_outlined),
              title: const Text("Discounts"),
              onTap: () {
                context.go(AppRoutes.discounts);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_sharp),
              title: const Text("Customers"),
              onTap: () {
                context.go(AppRoutes.customers);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Analytics"),
              onTap: () {
                context.go(AppRoutes.analytics);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                context.go(AppRoutes.settings);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Account"),
              onTap: () {
                context.go(AppRoutes.account);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text("Store"),
              onTap: () {
                context.go(AppRoutes.store);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cases_rounded),
              title: const Text("POS"),
              onTap: () {
                context.go(AppRoutes.pos);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("Team Management"),
              onTap: () {
                context.go(AppRoutes.teammanagement);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
