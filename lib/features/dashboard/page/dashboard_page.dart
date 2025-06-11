import 'package:flutter/material.dart';
import '../../analytics/page/analytics_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  int _selectedFilterIndex = 0;

  final _pages = [
    const AnalyticsPage(),
  ];

  final List<String> _filterOptions = [
    "Last 30 days",
    "Last 7 days", 
    "Last 24 hours",
    "Custom range"
  ];

  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add refresh logic here
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(),
              const SizedBox(height: 24),
              
              // Filter Section
              _buildFilterSection(),
              const SizedBox(height: 24),

              // Live Visitors Indicator
              _buildLiveVisitorsCard(),
              const SizedBox(height: 24),

              // Stats Overview
              _buildStatsGrid(),
              const SizedBox(height: 32),

              // Quick Actions
              _buildQuickActions(),
              const SizedBox(height: 24),

              // Promotional Section
              _buildPromotionalCard(),
              const SizedBox(height: 24),

              // Recent Activity Preview
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade600,
            Colors.blue.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back! 👋",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Here's what's happening with your store",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Analytics Period",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _filterOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = _selectedFilterIndex == index;
              
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _filterChip(
                  option,
                  selected: isSelected,
                  onTap: () => setState(() => _selectedFilterIndex = index),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveVisitorsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.radio_button_checked,
              color: Colors.green.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "30 Live Visitors",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
                Text(
                  "Active users on your site right now",
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("View Details"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Performance Overview",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _statCard(
              "Sessions",
              "49",
              change: "+63%",
              icon: Icons.people_outline,
              color: Colors.blue,
            ),
            _statCard(
              "Total Sales",
              "IDR 0",
              icon: Icons.attach_money,
              color: Colors.green,
            ),
            _statCard(
              "Orders",
              "0",
              icon: Icons.shopping_cart_outlined,
              color: Colors.orange,
            ),
            _statCard(
              "Conversion Rate",
              "0%",
              icon: Icons.trending_up,
              color: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                "Add Product",
                Icons.add_shopping_cart,
                Colors.blue,
                () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _actionButton(
                "View Orders",
                Icons.list_alt,
                Colors.green,
                () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _actionButton(
                "Analytics",
                Icons.analytics,
                Colors.purple,
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPromotionalCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade50,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 400;
            return isSmall
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _promoImage(),
                      const SizedBox(height: 20),
                      _promoText(),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _promoText()),
                      const SizedBox(width: 24),
                      _promoImage(),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _activityItem(
            "New visitor from Jakarta",
            "2 minutes ago",
            Icons.person_add_outlined,
          ),
          _activityItem(
            "Product viewed: Sample Item",
            "5 minutes ago",
            Icons.visibility_outlined,
          ),
          _activityItem(
            "Cart abandoned",
            "10 minutes ago",
            Icons.shopping_cart_outlined,
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, {bool selected = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.blue.shade600 : Colors.grey.shade300,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey.shade700,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _statCard(
  String label,
  String value, {
  String? change,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(16), // Reduced padding
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Important: Let column size itself
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(6), // Reduced padding
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 16), // Smaller icon
            ),
            if (change != null)
              Flexible( // Allow change badge to shrink if needed
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontSize: 10, // Smaller font
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8), // Reduced spacing
        Flexible( // Allow label to shrink
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12, // Smaller font
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 2), // Reduced spacing
        Flexible( // Allow value to shrink
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, // Smaller font
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

  Widget _actionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _promoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🚀 Boost conversion with a customized homepage",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Use apps to design a homepage that grabs attention, engages visitors, and drives more sales while helping your business stand out.",
          style: TextStyle(
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.visibility),
          label: const Text("VIEW APP GUIDE"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _promoImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/admin-dashboard.png',
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _activityItem(String title, String time, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: Colors.blue.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}