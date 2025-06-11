import 'package:flutter/material.dart';

class Customer {
  final String name;
  final String emailStatus;
  final String location;
  final int orders;
  final double spent;
  final int loyaltyPoints;
  final String joinDate;
  final String avatar;

  Customer(this.name, this.emailStatus, this.location, this.orders, this.spent,
      this.loyaltyPoints, this.joinDate, this.avatar);
}

List<Customer> customers = [
  Customer("Oki Rahmansah", "Subscribed", "Demak, JT, Indonesia", 24, 850000.0, 2450, "2023-01-15", "O"),
  Customer("Ayumu Hirano", "Not subscribed", "Tokyo, Japan", 18, 1200000.0, 1890, "2023-03-22", "A"),
  Customer("Russell Winfield", "Subscribed", "Toronto, Canada", 31, 2100000.0, 3200, "2022-11-08", "R"),
  Customer("Karine Ruby", "VIP", "Paris, France", 45, 3500000.0, 4750, "2022-08-12", "K"),
  Customer("Sarah Johnson", "Subscribed", "New York, USA", 12, 450000.0, 890, "2024-01-10", "S"),
  Customer("Miguel Santos", "Not subscribed", "São Paulo, Brazil", 8, 320000.0, 540, "2024-02-18", "M"),
];

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String _sortBy = 'name';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Customer> get filteredCustomers {
    List<Customer> filtered = customers.where((customer) {
      return customer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          customer.location.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Sort based on current tab
    if (_tabController.index == 1) {
      // Most Orders
      filtered.sort((a, b) => b.orders.compareTo(a.orders));
    } else if (_tabController.index == 2) {
      // Most Loyalty Points
      filtered.sort((a, b) => b.loyaltyPoints.compareTo(a.loyaltyPoints));
    } else {
      // All customers - sort by name
      if (_sortBy == 'name') {
        filtered.sort((a, b) => a.name.compareTo(b.name));
      } else if (_sortBy == 'spent') {
        filtered.sort((a, b) => b.spent.compareTo(a.spent));
      }
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'VIP':
        return Colors.amber;
      case 'Subscribed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'VIP':
        return Icons.star;
      case 'Subscribed':
        return Icons.mail;
      default:
        return Icons.mail_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Customers",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha),
                    SizedBox(width: 8),
                    Text('Sort by Name'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'spent',
                child: Row(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(width: 8),
                    Text('Sort by Spending'),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sort, size: 18, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Sort',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload, size: 18),
            label: const Text("Import"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, size: 18),
            label: const Text("Export"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search Bar
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search customers by name or location...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
              ),
              // Tab Bar
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue.shade600,
                  unselectedLabelColor: Colors.grey.shade600,
                  indicatorColor: Colors.blue.shade600,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  onTap: (index) {
                    setState(() {});
                  },
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.people, size: 18),
                          const SizedBox(width: 6),
                          Text('All (${customers.length})'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.shopping_cart, size: 18),
                          const SizedBox(width: 6),
                          const Text('Top Buyers'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars, size: 18),
                          const SizedBox(width: 6),
                          const Text('Most Loyal'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Stats Overview
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Customers",
                    customers.length.toString(),
                    Icons.people,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "VIP Members",
                    customers.where((c) => c.emailStatus == 'VIP').length.toString(),
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Subscribed",
                    customers.where((c) => c.emailStatus == 'Subscribed').length.toString(),
                    Icons.mail,
                    Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Customer List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCustomerList(),
                _buildCustomerList(),
                _buildCustomerList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.person_add),
        label: const Text("Add Customer"),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerList() {
    final filteredList = filteredCustomers;
    
    if (filteredList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No customers found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search terms',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final customer = filteredList[index];
        final isTopPerformer = _tabController.index == 1 && index < 3;
        final isMostLoyal = _tabController.index == 2 && index < 3;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              )
            ],
            border: (isTopPerformer || isMostLoyal)
                ? Border.all(
                    color: isTopPerformer ? Colors.orange.shade300 : Colors.purple.shade300,
                    width: 2,
                  )
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // Navigate to customer details
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: _getStatusColor(customer.emailStatus).withOpacity(0.2),
                          child: Text(
                            customer.avatar,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _getStatusColor(customer.emailStatus),
                            ),
                          ),
                        ),
                        if (isTopPerformer || isMostLoyal)
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isTopPerformer ? Colors.orange : Colors.purple,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isTopPerformer ? Icons.shopping_cart : Icons.star,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  customer.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(customer.emailStatus).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getStatusColor(customer.emailStatus).withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getStatusIcon(customer.emailStatus),
                                      size: 12,
                                      color: _getStatusColor(customer.emailStatus),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      customer.emailStatus,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _getStatusColor(customer.emailStatus),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: Colors.grey.shade500),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  customer.location,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              _buildInfoChip(
                                Icons.shopping_bag,
                                "${customer.orders} orders",
                                Colors.blue,
                              ),
                              _buildInfoChip(
                                Icons.attach_money,
                                "Rp ${(customer.spent / 1000).toStringAsFixed(0)}K",
                                Colors.green,
                              ),
                              _buildInfoChip(
                                Icons.stars,
                                "${customer.loyaltyPoints} pts",
                                Colors.amber,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}