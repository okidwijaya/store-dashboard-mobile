import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedPaymentStatus = 'Pending';
  String _selectedPaymentMethod = 'Cash';
  List<OrderItem> _orderItems = [];
  bool _emailReceipt = false;
  bool _showSearchResults = false;

  final List<String> _paymentStatusOptions = [
    'Pending',
    'Paid',
    'Failed',
    'Cancelled'
  ];

  final List<String> _paymentMethodOptions = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'Bank Transfer',
    'E-Wallet'
  ];

  // Sample products for demo
  final List<OrderItem> _searchResults = [
    OrderItem(name: 'T-Shirt', price: 29.99),
    OrderItem(name: 'Jeans', price: 59.99),
    OrderItem(name: 'Sneakers', price: 89.99),
  ];

  double get _subtotal => _orderItems.fold(
      0, (sum, item) => sum + (item.price * item.quantity));
  double get _tax => _subtotal * 0.1;
  double get _total => _subtotal + _tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _saveOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Save'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductSearch(),
              if (_showSearchResults) _buildSearchResults(),
              SizedBox(height: 24),
              if (_orderItems.isNotEmpty) _buildOrderItems(),
              SizedBox(height: 24),
              _buildPaymentDetails(),
              SizedBox(height: 24),
              _buildNotes(),
              SizedBox(height: 24),
              _buildOrderSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildProductSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _showSearchResults = value.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Card(
      margin: EdgeInsets.only(top: 8),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _searchResults.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _orderItems.add(product);
                  _searchController.clear();
                  _showSearchResults = false;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderItems() {
    return _buildCard(
      title: 'Order Items',
      child: Column(
        children: [
          for (var item in _orderItems) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        icon: Icon(Icons.remove, size: 16),
                        padding: EdgeInsets.zero,
                        onPressed: () => _updateItemQuantity(
                            _orderItems.indexOf(item), -1),
                      ),
                    ),
                    SizedBox(width: 4),
                    Container(
                      width: 32,
                      alignment: Alignment.center,
                      child: Text(
                        item.quantity.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        icon: Icon(Icons.add, size: 16),
                        padding: EdgeInsets.zero,
                        onPressed: () => _updateItemQuantity(
                            _orderItems.indexOf(item), 1),
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        icon: Icon(Icons.delete_outline, size: 16),
                        padding: EdgeInsets.zero,
                        onPressed: () => _removeItem(_orderItems.indexOf(item)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_orderItems.indexOf(item) != _orderItems.length - 1)
              Divider(),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return _buildCard(
      title: 'Payment Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Status', style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedPaymentStatus,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _paymentStatusOptions.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentStatus = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _paymentMethodOptions.map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return _buildCard(
      title: 'Notes',
      child: Column(
        children: [
          TextFormField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add notes about the order...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _emailReceipt,
                onChanged: (value) {
                  setState(() {
                    _emailReceipt = value!;
                  });
                },
              ),
              Text('Email receipt to customer'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return _buildCard(
      title: 'Order Summary',
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', _calculateSubtotal()),
          SizedBox(height: 8),
          _buildSummaryRow('Tax (10%)', _calculateTax()),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 8),
          _buildSummaryRow('Total', _calculateTotal(), isTotal: true),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Create Order'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _updateItemQuantity(int index, int change) {
    setState(() {
      _orderItems[index].quantity += change;
      if (_orderItems[index].quantity < 1) {
        _orderItems.removeAt(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _orderItems.removeAt(index);
    });
  }

  void _saveOrder() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement order saving
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  double _calculateSubtotal() {
    return _orderItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double _calculateTax() {
    return _calculateSubtotal() * 0.1; // 10% tax
  }

  double _calculateTotal() {
    return _calculateSubtotal() + _calculateTax();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Handle order submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

class OrderItem {
  final String name;
  final double price;
  int quantity;

  OrderItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}