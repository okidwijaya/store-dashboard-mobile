import 'package:bayme/features/shared/widget/header/HeaderNavigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bayme/routing/routes.dart';
import '../../../ui/features/home/widgets/navigation_drawer.dart' as custom;

// Pages import
import 'package:bayme/features/home/home_page.dart';
import 'package:bayme/features/auth/pages/register_page.dart';
import '../features/dashboard/page/dashboard_page.dart';
import '../features/inventory/page/inventory_page.dart';
import '../features/sales/page/sales_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/analytics/page/analytics_page.dart';
import '../features/products/page/products_page.dart';
import '../features/products/page/add/add_product_page.dart';
import '../features/orders/page/orders_page.dart';
import '../features/orders/page/add/add_order_page.dart';
import '../features/discounts/page/discounts_page.dart';
import '../features/discounts/page/add/add_discount_page.dart';
import '../features/customers/page/customers_page.dart';
import '../features/customers/page/add/add_customer_page.dart';
import '../features/settings/page/settings_page.dart';
import '../features/account/page/account_page.dart';
import '../features/store/page/store_page.dart';
import '../features/pos/page/pos_page.dart';
import 'package:bayme/features/teammanagement/page/teammanagement_page.dart';
import 'package:bayme/features/reports/pages/report_page.dart';

// Function to get page title based on current route
String _getPageTitle(String location) {
  switch (location) {
    case AppRoutes.dashboard:
      return 'Dashboard';
    case AppRoutes.products:
      return 'Products';
    case AppRoutes.products + '/add':
      return 'Add Product';
    case AppRoutes.inventory:
      return 'Inventory';
    case AppRoutes.orders:
      return 'Orders';
    case AppRoutes.orders + '/add':
      return 'Add Order';
    case AppRoutes.discounts:
      return 'Discounts';
    case AppRoutes.discounts + '/add':
      return 'Add Discount';
    case AppRoutes.customers:
      return 'Customers';
    case AppRoutes.customers + '/add':
      return 'Add Customer';
    case AppRoutes.analytics:
      return 'Analytics';
    case AppRoutes.settings:
      return 'Settings';
    case AppRoutes.account:
      return 'Account';
    case AppRoutes.store:
      return 'Store';
    case AppRoutes.pos:
      return 'POS';
    case AppRoutes.teammanagement:
      return 'Team Management';
    case AppRoutes.sales:
      return 'Sales';
    case AppRoutes.reports:
      return 'Reports';
    default:
      return 'Bayme';
  }
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        // Get the current page title based on the route
        final currentTitle = _getPageTitle(state.uri.toString());

        return Scaffold(
          appBar: HeaderNavigation(
            title: currentTitle,
            notificationCount: 3,
            onSearchPressed: () => _handleSearch(context),
            onNotificationPressed: () => _handleNotifications(context),
            onProfilePressed: () => _handleProfile(context),
          ),
          drawer: const custom.NavigationDrawer(),
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) => DashboardPage(),
        ),
        GoRoute(
          path: AppRoutes.products,
          builder: (context, state) => const ProductsPage(),
        ),
        GoRoute(
          path: AppRoutes.addproduct,
          builder: (context, state) => AddProductPage(),
        ),
        GoRoute(
          path: AppRoutes.inventory,
          builder: (context, state) => const InventoryPage(),
        ),
        GoRoute(
          path: AppRoutes.orders,
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: AppRoutes.addorder,
          builder: (context, state) => AddOrderPage(),
        ),
        GoRoute(
          path: AppRoutes.discounts,
          builder: (context, state) => const DiscountsPage(),
        ),
        GoRoute(
          path: AppRoutes.addDiscount,
          builder: (context, state) => AddDiscountPage(),
        ),
        GoRoute(
          path: AppRoutes.customers,
          builder: (context, state) => const CustomersPage(),
        ),
        GoRoute(
          path: AppRoutes.addcustomer,
          builder: (context, state) => AddCustomerPage(),
        ),
        GoRoute(
          path: AppRoutes.analytics,
          builder: (context, state) => const AnalyticsPage(),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.account,
          builder: (context, state) => const AccountPage(),
        ),
        GoRoute(
          path: AppRoutes.store,
          builder: (context, state) => const StorePage(),
        ),
        GoRoute(
          path: AppRoutes.pos,
          builder: (context, state) => const PosPage(),
        ),
        GoRoute(
          path: AppRoutes.teammanagement,
          builder: (context, state) => const TeammanagementPage(),
        ),
        GoRoute(
          path: AppRoutes.sales,
          builder: (context, state) => const SalesPage(),
        ),
        GoRoute(
          path: AppRoutes.reports,
          builder: (context, state) => const ReportsPage(),
        ),
      ],
    ),
  ],
);

void _handleSearch(BuildContext context) {
  // Handle search functionality
  print('Search pressed');
}

void _handleNotifications(BuildContext context) {
  // Handle notifications
  print('Notifications pressed');
}

void _handleProfile(BuildContext context) {
  // Handle profile menu
  print('Profile pressed');
}
