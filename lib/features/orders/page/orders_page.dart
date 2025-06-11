import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String selectedTab = "All";
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: isSearching 
          ? TextField(
              controller: searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search orders...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.black87),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            )
          : const Text(
              'Orders Management',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
        centerTitle: !isSearching,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  searchController.clear();
                  searchQuery = "";
                } else {
                  isSearching = true;
                }
              });
            },
            icon: Icon(isSearching ? Icons.close : Icons.search),
          ),
          if (!isSearching)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Summary Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  isTablet 
                    ? Row(
                        children: [
                          Expanded(child: _buildSummaryGrid()),
                        ],
                      )
                    : _buildSummaryGrid(),
                ],
              ),
            ),
            
            const SizedBox(height: 8),

            // Enhanced Tabs Section
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Order Status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('New Order'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _OrderTabs(
                    selectedTab: selectedTab,
                    onTabSelected: (tab) {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Enhanced Orders List
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Orders (${_getFilteredOrdersCount()})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Sort by: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            DropdownButton<String>(
                              value: 'Date',
                              underline: Container(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                              items: ['Date', 'Amount', 'Status']
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ..._buildOrdersList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create Order'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildSummaryGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _enhancedSummaryCard(
          "Total Orders",
          "3",
          Icons.shopping_cart_outlined,
          Colors.blue,
          "+2 this week",
        ),
        _enhancedSummaryCard(
          "Items Ordered",
          "7",
          Icons.inventory_2_outlined,
          Colors.green,
          "+5 this week",
        ),
        _enhancedSummaryCard(
          "Revenue",
          "Rp 746.4K",
          Icons.trending_up_outlined,
          Colors.purple,
          "+12% vs last week",
        ),
        _enhancedSummaryCard(
          "Fulfilled",
          "1 of 3",
          Icons.check_circle_outline,
          Colors.orange,
          "33% completion",
        ),
      ],
    );
  }

  Widget _enhancedSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  int _getFilteredOrdersCount() {
    return _getFilteredOrders().length;
  }

  List<Map<String, dynamic>> _getFilteredOrders() {
    final allOrders = [
      {
        "orderId": "#1003",
        "date": "Nov 14 at 5:08 am",
        "customer": "Oki Rahmansah",
        "customerAvatar": "OR",
        "total": "Rp 864.55",
        "itemCount": 2,
        "paymentStatus": "Paid",
        "fulfillmentStatus": "Unfulfilled",
        "deliveryStatus": "",
        "isUrgent": true,
      },
      {
        "orderId": "#1002",
        "date": "Oct 13 at 11:55 pm",
        "customer": "Oki Rahmansah",
        "customerAvatar": "OR",
        "total": "Rp 372,900.00",
        "itemCount": 3,
        "paymentStatus": "Paid",
        "fulfillmentStatus": "Fulfilled",
        "deliveryStatus": "Tracking added",
        "isUrgent": false,
      },
      {
        "orderId": "#1001",
        "date": "Oct 13 at 8:10 am",
        "customer": "Oki Rahmansah",
        "customerAvatar": "OR",
        "total": "Rp 372,900.00",
        "itemCount": 2,
        "paymentStatus": "Paid",
        "fulfillmentStatus": "Unfulfilled",
        "deliveryStatus": "",
        "isUrgent": false,
      },
    ];

    // Filter by search query
    var filteredOrders = allOrders;
    if (searchQuery.isNotEmpty) {
      filteredOrders = allOrders.where((order) {
        return order["orderId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["total"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by selected tab
    if (selectedTab != "All") {
      filteredOrders = filteredOrders.where((order) {
        switch (selectedTab) {
          case "Unfulfilled":
            return order["fulfillmentStatus"] == "Unfulfilled";
          case "Unpaid":
            return order["paymentStatus"] != "Paid";
          case "Open":
            return order["fulfillmentStatus"] == "Unfulfilled" || order["paymentStatus"] != "Paid";
          case "Archived":
            return false; // No archived orders in this example
          default:
            return true;
        }
      }).toList();
    }

    return filteredOrders;
  }

  List<Widget> _buildOrdersList() {
    final filteredOrders = _getFilteredOrders();
    
    if (filteredOrders.isEmpty) {
      return [
        Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Icon(
                searchQuery.isNotEmpty ? Icons.search_off : Icons.inbox_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                searchQuery.isNotEmpty 
                  ? 'No orders found for "$searchQuery"'
                  : 'No orders found',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ];
    }

    return filteredOrders.map((order) => _EnhancedOrderTile(
      orderId: order["orderId"],
      date: order["date"],
      customer: order["customer"],
      customerAvatar: order["customerAvatar"],
      total: order["total"],
      itemCount: order["itemCount"],
      paymentStatus: order["paymentStatus"],
      fulfillmentStatus: order["fulfillmentStatus"],
      deliveryStatus: order["deliveryStatus"],
      isUrgent: order["isUrgent"],
    )).toList();
  }
}

class _OrderTabs extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;

  const _OrderTabs({
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {"name": "All", "count": "3"},
      {"name": "Unfulfilled", "count": "2"},
      {"name": "Unpaid", "count": "0"},
      {"name": "Open", "count": "2"},
      {"name": "Archived", "count": "0"},
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = selectedTab == tab["name"];
          
          return GestureDetector(
            onTap: () => onTabSelected(tab["name"]!),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade600 : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tab["name"]!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  if (tab["count"] != "0") ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        tab["count"]!,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EnhancedOrderTile extends StatelessWidget {
  final String orderId;
  final String date;
  final String customer;
  final String customerAvatar;
  final String total;
  final int itemCount;
  final String paymentStatus;
  final String fulfillmentStatus;
  final String deliveryStatus;
  final bool isUrgent;

  const _EnhancedOrderTile({
    required this.orderId,
    required this.date,
    required this.customer,
    required this.customerAvatar,
    required this.total,
    required this.itemCount,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.deliveryStatus,
    required this.isUrgent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  if (isUrgent) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'URGENT',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.more_vert,
                    color: Colors.grey.shade400,
                    size: 16,
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Customer Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      customerAvatar,
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '$itemCount items',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        total,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Status Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _enhancedStatusChip(
                    paymentStatus,
                    _getPaymentStatusColor(paymentStatus),
                    Icons.payment,
                  ),
                  _enhancedStatusChip(
                    fulfillmentStatus,
                    _getFulfillmentStatusColor(fulfillmentStatus),
                    fulfillmentStatus == "Fulfilled" 
                        ? Icons.check_circle_outline 
                        : Icons.pending_outlined,
                  ),
                  if (deliveryStatus.isNotEmpty)
                    _enhancedStatusChip(
                      deliveryStatus,
                      Colors.blue.shade600,
                      Icons.local_shipping_outlined,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _enhancedStatusChip(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green.shade600;
      case 'pending':
        return Colors.orange.shade600;
      case 'failed':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _getFulfillmentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'fulfilled':
        return Colors.green.shade600;
      case 'unfulfilled':
        return Colors.orange.shade600;
      case 'cancelled':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}