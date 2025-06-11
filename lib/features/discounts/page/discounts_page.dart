import 'package:flutter/material.dart';

class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = '';
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> discounts = [
    {
      "id": "1",
      "title": "SUMMER25",
      "subtitle": "25% off all summer items • Min purchase Rp 100,000",
      "status": "Active",
      "method": "Code",
      "type": "Amount off products",
      "discount": "25%",
      "minPurchase": "Rp 100K",
      "uses": 234,
      "totalSavings": "Rp 12.5M",
      "validUntil": "Aug 31, 2024",
      "isFavorite": true,
      "performance": "high",
      "categories": ["Summer", "Clothing"],
    },
    {
      "id": "2",
      "title": "FREESHIP100",
      "subtitle": "Free shipping for orders above Rp 100,000",
      "status": "Active",
      "method": "Code",
      "type": "Free shipping",
      "discount": "Free",
      "minPurchase": "Rp 100K",
      "uses": 189,
      "totalSavings": "Rp 2.8M",
      "validUntil": "Dec 31, 2024",
      "isFavorite": false,
      "performance": "medium",
      "categories": ["Shipping"],
    },
    {
      "id": "3",
      "title": "NEWCUSTOMER50",
      "subtitle": "50% off first purchase • New customers only",
      "status": "Active",
      "method": "Automatic",
      "type": "Amount off order",
      "discount": "50%",
      "minPurchase": "Rp 50K",
      "uses": 67,
      "totalSavings": "Rp 3.2M",
      "validUntil": "Sep 15, 2024",
      "isFavorite": true,
      "performance": "high",
      "categories": ["New Customer"],
    },
    {
      "id": "4",
      "title": "BOGO-SHOES",
      "subtitle": "Buy 1 shoe, get 1 shoe free • Limited time",
      "status": "Scheduled",
      "method": "Automatic",
      "type": "Buy X Get Y",
      "discount": "BOGO",
      "minPurchase": "None",
      "uses": 0,
      "totalSavings": "Rp 0",
      "validUntil": "Jul 1-15, 2024",
      "isFavorite": false,
      "performance": "new",
      "categories": ["Shoes", "BOGO"],
    },
    {
      "id": "5",
      "title": "BLACKFRIDAY",
      "subtitle": "80% off one-time purchase products • Min quantity of 1",
      "status": "Expired",
      "method": "Code",
      "type": "Amount off order",
      "discount": "80%",
      "minPurchase": "None",
      "uses": 1205,
      "totalSavings": "Rp 45.2M",
      "validUntil": "Nov 29, 2023",
      "isFavorite": true,
      "performance": "high",
      "categories": ["Seasonal", "Black Friday"],
    },
    {
      "id": "6",
      "title": "STUDENT10",
      "subtitle": "10% off for students • Valid student ID required",
      "status": "Inactive",
      "method": "Code",
      "type": "Amount off products",
      "discount": "10%",
      "minPurchase": "None",
      "uses": 45,
      "totalSavings": "Rp 890K",
      "validUntil": "Paused",
      "isFavorite": false,
      "performance": "low",
      "categories": ["Student", "Education"],
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "Discount Management",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(49),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue.shade600,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: Colors.blue.shade600,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: [
                Tab(text: 'All (${discounts.length})'),
                Tab(text: 'Active (${_getCountByStatus("Active")})'),
                Tab(text: 'Scheduled (${_getCountByStatus("Scheduled")})'),
                Tab(text: 'Expired (${_getCountByStatus("Expired")})'),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.analytics_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Analytics Overview
            _buildAnalyticsOverview(),

            // Search and Filters
            _buildSearchAndFilters(),

            // Quick Stats
            _buildQuickStats(),

            // Discounts List
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDiscountList(discounts),
                  _buildDiscountList(
                      discounts.where((d) => d['status'] == 'Active').toList()),
                  _buildDiscountList(discounts
                      .where((d) => d['status'] == 'Scheduled')
                      .toList()),
                  _buildDiscountList(discounts
                      .where((d) => d['status'] == 'Expired')
                      .toList()),
                ],
              ),
            ),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Create Discount"),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  "Total Savings",
                  "Rp 64.4M",
                  Icons.savings_outlined,
                  Colors.green,
                  "+18% vs last month",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  "Active Discounts",
                  "${_getCountByStatus("Active")}",
                  Icons.local_offer_outlined,
                  Colors.blue,
                  "${_getCountByStatus("Scheduled")} scheduled",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  "Most Used",
                  "BLACKFRIDAY",
                  Icons.trending_up_outlined,
                  Colors.purple,
                  "1,205 uses",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  "Conversion Rate",
                  "23.5%",
                  Icons.analytics_outlined,
                  Colors.orange,
                  "+5.2% this week",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.13)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const Spacer(),
              if (title == "Conversion Rate" || title == "Total Savings")
                Icon(Icons.trending_up, color: color, size: 18)
              else if (title == "Active Discounts")
                Icon(Icons.schedule, color: color, size: 18)
              else if (title == "Most Used")
                Icon(Icons.star, color: color, size: 18)
            ],
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.search, color: Colors.grey.shade600),
                      hintText: 'Search discounts...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => _showFilterDialog(),
                  icon: Icon(Icons.tune, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip("All", selectedFilter == "All"),
                const SizedBox(width: 8),
                _buildFilterChip("Favorites", selectedFilter == "Favorites"),
                const SizedBox(width: 8),
                _buildFilterChip(
                    "High Performance", selectedFilter == "High Performance"),
                const SizedBox(width: 8),
                _buildFilterChip("Code-based", selectedFilter == "Code-based"),
                const SizedBox(width: 8),
                _buildFilterChip("Automatic", selectedFilter == "Automatic"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = isSelected ? "All" : label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade600 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    final favoriteDiscounts =
        discounts.where((d) => d['isFavorite'] == true).toList();
    final mostUsed = discounts.reduce((a, b) => a['uses'] > b['uses'] ? a : b);
    final inactiveCount = _getCountByStatus("Inactive");

    return Container(
      // margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Insights',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _buildQuickStatItem(
                  "Favorites",
                  "${favoriteDiscounts.length}",
                  Icons.favorite_outlined,
                  Colors.red,
                ),
              ),
              Expanded(
                child: _buildQuickStatItem(
                  "Most Used",
                  mostUsed['title'],
                  Icons.star_outlined,
                  Colors.amber,
                ),
              ),
              Expanded(
                child: _buildQuickStatItem(
                  "Inactive",
                  "$inactiveCount",
                  Icons.pause_circle_outlined,
                  Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatItem(
      String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountList(List<Map<String, dynamic>> items) {
    final filteredItems = _filterDiscounts(items);

    if (filteredItems.isEmpty) {
      return SingleChildScrollView(
        padding:
            const EdgeInsets.only(bottom: 100), // 👈 Enough padding for FAB
        child: SizedBox(
          height: MediaQuery.of(context).size.height *
              0.6, // optional: center vertically
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.discount_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No discounts found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filters',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: filteredItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildEnhancedDiscountCard(item);
      },
    );
  }

  Widget _buildEnhancedDiscountCard(Map<String, dynamic> discount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _getStatusColor(discount['status'])
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getDiscountIcon(discount['type']),
                            color: _getStatusColor(discount['status']),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      discount['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  if (discount['isFavorite'])
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red.shade400,
                                      size: 16,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                discount['subtitle'],
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildStatusChip(discount['status']),
                      const SizedBox(height: 4),
                      Text(
                        discount['validUntil'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Metrics Row
              Row(
                children: [
                  _buildMetric("Discount", discount['discount'], Icons.percent),
                  const SizedBox(width: 16),
                  _buildMetric(
                      "Uses", "${discount['uses']}", Icons.people_outline),
                  const SizedBox(width: 16),
                  _buildMetric("Savings", discount['totalSavings'],
                      Icons.savings_outlined),
                  const Spacer(),
                  Row(
                    children: [
                      _buildMethodIcon(discount['method']),
                      const SizedBox(width: 8),
                      _buildPerformanceIndicator(discount['performance']),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Categories Tags
              if (discount['categories'] != null)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (discount['categories'] as List<String>)
                      .take(3)
                      .map((category) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getStatusColor(status).withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMethodIcon(String method) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:
            method == "Code" ? Colors.orange.shade100 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        method == "Code"
            ? Icons.confirmation_num_outlined
            : Icons.auto_awesome_outlined,
        size: 14,
        color:
            method == "Code" ? Colors.orange.shade700 : Colors.green.shade700,
      ),
    );
  }

  Widget _buildPerformanceIndicator(String performance) {
    Color color;
    IconData icon;

    switch (performance) {
      case 'high':
        color = Colors.green;
        icon = Icons.trending_up;
        break;
      case 'medium':
        color = Colors.orange;
        icon = Icons.trending_flat;
        break;
      case 'low':
        color = Colors.red;
        icon = Icons.trending_down;
        break;
      default:
        color = Colors.grey;
        icon = Icons.fiber_new;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green.shade600;
      case 'scheduled':
        return Colors.blue.shade600;
      case 'expired':
        return Colors.red.shade600;
      case 'inactive':
        return Colors.grey.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  IconData _getDiscountIcon(String type) {
    switch (type) {
      case "Buy X Get Y":
        return Icons.local_offer_outlined;
      case "Free shipping":
        return Icons.local_shipping_outlined;
      case "Amount off order":
        return Icons.receipt_outlined;
      case "Amount off products":
        return Icons.shopping_cart_outlined;
      default:
        return Icons.discount_outlined;
    }
  }

  List<Map<String, dynamic>> _filterDiscounts(
      List<Map<String, dynamic>> items) {
    var filtered = items;

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((item) =>
              item['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
              item['subtitle']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    switch (selectedFilter) {
      case "Favorites":
        filtered =
            filtered.where((item) => item['isFavorite'] == true).toList();
        break;
      case "High Performance":
        filtered =
            filtered.where((item) => item['performance'] == 'high').toList();
        break;
      case "Code-based":
        filtered = filtered.where((item) => item['method'] == 'Code').toList();
        break;
      case "Automatic":
        filtered =
            filtered.where((item) => item['method'] == 'Automatic').toList();
        break;
    }

    return filtered;
  }

  int _getCountByStatus(String status) {
    return discounts.where((d) => d['status'] == status).length;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Filter options would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
