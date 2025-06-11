import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with TickerProviderStateMixin {
  String _searchQuery = '';
  String _selectedStatus = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _getFilteredProducts() {
    var filtered = products.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              (product.category
                      ?.toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ??
                  false);

      final matchesStatus = _selectedStatus == 'All' ||
          product.status.toLowerCase() == _selectedStatus.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          'Products Management',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.file_upload_outlined),
            tooltip: 'Import/Export',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Advanced Filter',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
            tooltip: 'More Options',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMetricsSection(),
          _buildSearchAndFilters(),
          Expanded(
            child: _buildProductsList(isTablet),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.blue[600],
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text("Add Product", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildMetricsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2.5, // Increased from 2 to 2.5 to give more height
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildMetricCard("Sessions", "49", "+63%", Icons.trending_up_rounded,
              Colors.green),
          _buildMetricCard("Total Sales", "IDR 0", null,
              Icons.attach_money_rounded, Colors.blue),
          _buildMetricCard(
              "Orders", "0", null, Icons.shopping_cart_rounded, Colors.orange),
          _buildMetricCard(
              "Conversion", "0%", null, Icons.analytics_rounded, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String? subtitle,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24), // Reduced from 28 to 24
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Added this to prevent overflow
              children: [
                Flexible( // Wrapped with Flexible
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                Flexible( // Wrapped with Flexible
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13, // Reduced from 14 to 13
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (subtitle != null)
                  Flexible( // Wrapped with Flexible
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 9, // Reduced from 10 to 9
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search products, categories...",
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
          const SizedBox(height: 12),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All', 'Active', 'Draft', 'Archived'].map((status) {
                final isSelected = _selectedStatus == status;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(status),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedStatus = status;
                      });
                    },
                    backgroundColor: Colors.grey[100],
                    selectedColor: Colors.blue[600]?.withOpacity(0.2),
                    checkmarkColor: Colors.blue[600],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue[600] : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(bool isTablet) {
    final filteredProducts = _getFilteredProducts();

    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No products found",
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
      itemCount: filteredProducts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return _buildProductCard(product, isTablet);
      },
    );
  }

  Widget _buildProductCard(Product product, bool isTablet) {
    Color statusColor = _getStatusColor(product.status);
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
                    child: Icon(
                      _getProductIcon(product.name),
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (product.category != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            product.category!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                    const PopupMenuItem(
                        value: 'edit', child: Text('Edit Product')),
                    const PopupMenuItem(
                        value: 'duplicate', child: Text('Duplicate')),
                    const PopupMenuItem(
                        value: 'archive', child: Text('Archive')),
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
                        "Inventory",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.inventory,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        product.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isTablet && product.variants != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.layers_rounded,
                        size: 16, color: Colors.blue[600]),
                    const SizedBox(width: 6),
                    Text(
                      "${product.variants} variants available",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green[600]!;
      case 'draft':
        return Colors.orange[600]!;
      case 'archived':
        return Colors.grey[600]!;
      default:
        return Colors.blue[600]!;
    }
  }

  IconData _getProductIcon(String productName) {
    final name = productName.toLowerCase();

    if (name.contains('serum')) return Icons.water_drop_rounded;
    if (name.contains('cleanser')) return Icons.soap_rounded;
    if (name.contains('moisturizer') || name.contains('cream'))
      return Icons.face_rounded;
    if (name.contains('patch')) return Icons.healing_rounded;
    if (name.contains('exfoliant')) return Icons.auto_fix_high_rounded;

    return Icons.inventory_2_rounded;
  }
}

class Product {
  final String name;
  final String status;
  final String inventory;
  final String? category;
  final int? variants;

  Product({
    required this.name,
    required this.status,
    required this.inventory,
    this.category,
    this.variants,
  });
}

final products = [
  Product(
    name: 'Dark Spot Serum',
    status: 'Draft',
    inventory: 'Not tracked',
    category: 'Skincare',
  ),
  Product(
    name: 'Liquid Pore Exfoliant',
    status: 'Draft',
    inventory: 'Not tracked',
    category: 'Skincare',
  ),
  Product(
    name: 'Emergency Spot Patch',
    status: 'Draft',
    inventory: 'Not tracked',
    category: 'Treatment',
  ),
  Product(
    name: 'Cream Moisturizer',
    status: 'Draft',
    inventory: 'Not tracked',
    category: 'Skincare',
  ),
  Product(
    name: 'Acne Cleanser',
    status: 'Active',
    inventory: '1,019 in stock',
    category: 'Skincare',
    variants: 6,
  ),
  Product(
    name: 'Vitamin C Serum',
    status: 'Active',
    inventory: '245 in stock',
    category: 'Skincare',
    variants: 3,
  ),
  Product(
    name: 'Retinol Night Cream',
    status: 'Active',
    inventory: '89 in stock',
    category: 'Anti-aging',
    variants: 2,
  ),
  Product(
    name: 'Hydrating Toner',
    status: 'Archived',
    inventory: '0 in stock',
    category: 'Skincare',
  ),
];