import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> inventoryData = const [
    {
      "name": "Batik Tulis Motif Parang",
      "sku": "BT-001",
      "status": "In stock",
      "stock": 25,
      "available": 23,
      "price": "Rp 450,000",
      "category": "Textiles",
      "image": "🎨"
    },
    {
      "name": "Tas Anyaman Rotan",
      "sku": "TR-102",
      "status": "In stock",
      "stock": 12,
      "available": 10,
      "price": "Rp 320,000",
      "category": "Accessories",
      "image": "👜"
    },
    {
      "name": "Songket Palembang",
      "sku": "SP-035",
      "status": "Low stock",
      "stock": 5,
      "available": 5,
      "price": "Rp 1,200,000",
      "category": "Textiles",
      "image": "🧵"
    },
    {
      "name": "Gula Aren Organik",
      "sku": "GA-250",
      "status": "In stock",
      "stock": 50,
      "available": 47,
      "price": "Rp 35,000",
      "category": "Food",
      "image": "🍯"
    },
    {
      "name": "Keripik Pisang Coklat",
      "sku": "KP-100",
      "status": "Out of stock",
      "stock": 0,
      "available": 0,
      "price": "Rp 15,000",
      "category": "Food",
      "image": "🍌"
    },
    {
      "name": "Tenun Ikat Lombok",
      "sku": "TI-221",
      "status": "Low stock",
      "stock": 8,
      "available": 8,
      "price": "Rp 850,000",
      "category": "Textiles",
      "image": "🧶"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredData() {
    var filtered = inventoryData.where((item) {
      return item['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
             item['sku'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    switch (_tabController.index) {
      case 1:
        return filtered.where((item) => item['status'] == 'In stock').toList();
      case 2:
        return filtered.where((item) => item['status'] == 'Low stock').toList();
      case 3:
        return filtered.where((item) => item['status'] == 'Out of stock').toList();
      default:
        return filtered;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          "Inventory Management",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // Add filter functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              // Add more options
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              _buildSearchBar(),
              _buildTabBar(),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _buildStatsSection(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(4, (index) => _buildInventoryList()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new inventory item
        },
        backgroundColor: Colors.blue[600],
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text("Add Item", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: "Search by name or SKU...",
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        onTap: (index) => setState(() {}),
        labelColor: Colors.blue[600],
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Colors.blue[600],
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'All Items'),
          Tab(text: 'In Stock'),
          Tab(text: 'Low Stock'),
          Tab(text: 'Out of Stock'),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildStatCard("Total Inventory", "231", Icons.inventory_2_rounded, Colors.blue),
          _buildStatCard("Active Items", "187", Icons.check_circle_rounded, Colors.green),
          _buildStatCard("Out of Stock", "44", Icons.warning_rounded, Colors.orange),
          _buildStatCard("Total Value", "Rp 23.5M", Icons.attach_money_rounded, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryList() {
    final filteredData = _getFilteredData();
    
    if (filteredData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No items found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = filteredData[index];
        return _buildInventoryCard(item);
      },
    );
  }

  Widget _buildInventoryCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item['status']);
    Color statusBgColor = statusColor.withOpacity(0.1);

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      item['image'],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item['sku'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['category'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert_rounded, color: Colors.grey[600]),
                  onSelected: (value) {
                    // Handle menu actions
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'duplicate', child: Text('Duplicate')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['price'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stock",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${item['available']}/${item['stock']} available",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In stock':
        return Colors.green[600]!;
      case 'Low stock':
        return Colors.orange[600]!;
      case 'Out of stock':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }
}