import 'package:flutter/material.dart';

class AddDiscountPage extends StatefulWidget {
  const AddDiscountPage({super.key});

  @override
  State<AddDiscountPage> createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _minimumAmountController = TextEditingController();
  final _maximumAmountController = TextEditingController();
  final _limitPerCustomerController = TextEditingController();
  final _totalLimitController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedDiscountType = 'Percentage';
  double _discountValue = 0;
  bool _isActive = true;

  final List<String> _discountTypes = [
    'Percentage',
    'Fixed Amount',
    'Buy X Get Y Free',
    'Free Shipping',
    'First Purchase',
    'Bundle Discount',
    'Minimum Purchase',
    'Seasonal Discount',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Discount',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _saveDiscount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Save', style: TextStyle(fontSize: 14)),
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
              _buildDiscountDetails(),
              SizedBox(height: 24),
              _buildDiscountConditions(),
              SizedBox(height: 24),
              _buildValidityPeriod(),
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildDiscountDetails() {
    return _buildCard(
      title: 'Discount Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: 'Discount Name',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter discount name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _codeController,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: 'Discount Code',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter discount code';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          // Discount Type Dropdown
          DropdownButtonFormField<String>(
            value: _selectedDiscountType,
            isExpanded: true,
            style: TextStyle(fontSize: 14, color: Colors.black87),
            decoration: InputDecoration(
              labelText: 'Discount Type',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: _discountTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type,
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDiscountType = value!;
                _discountValue = 0; // Reset value when type changes
              });
            },
          ),
          SizedBox(height: 16),
          // Discount Value Field
          if (_selectedDiscountType != 'Free Shipping')
            TextFormField(
              initialValue: _discountValue.toString(),
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _getValueFieldLabel(),
                hintText: _getValueFieldHint(),
                labelStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                final number = double.tryParse(value);
                if (number == null) {
                  return 'Please enter a valid number';
                }
                if (_selectedDiscountType == 'Percentage' && (number < 0 || number > 100)) {
                  return 'Percentage must be between 0 and 100';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _discountValue = double.tryParse(value) ?? 0;
                });
              },
            ),
          SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            style: TextStyle(fontSize: 14),
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Switch(
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(width: 8),
              Text(
                'Active',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getValueFieldLabel() {
    switch (_selectedDiscountType) {
      case 'Percentage':
        return 'Percentage (%)';
      case 'Fixed Amount':
        return 'Amount';
      case 'Buy X Get Y Free':
        return 'Buy X items';
      case 'First Purchase':
      case 'Seasonal Discount':
        return 'Discount Value';
      case 'Bundle Discount':
        return 'Bundle Size';
      case 'Minimum Purchase':
        return 'Minimum Amount';
      default:
        return 'Value';
    }
  }

  String _getValueFieldHint() {
    switch (_selectedDiscountType) {
      case 'Percentage':
        return 'Enter percentage (0-100)';
      case 'Fixed Amount':
        return 'Enter amount';
      case 'Buy X Get Y Free':
        return 'Enter number of items to buy';
      case 'First Purchase':
      case 'Seasonal Discount':
        return 'Enter discount value';
      case 'Bundle Discount':
        return 'Enter minimum items for bundle';
      case 'Minimum Purchase':
        return 'Enter minimum amount';
      default:
        return 'Enter value';
    }
  }

  Widget _buildDiscountConditions() {
    return _buildCard(
      title: 'Conditions',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _minimumAmountController,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Minimum Amount',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _maximumAmountController,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Maximum Amount',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _limitPerCustomerController,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Usage Limit Per Customer',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _totalLimitController,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Total Usage Limit',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidityPeriod() {
    return _buildCard(
      title: 'Validity Period',
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              readOnly: true,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Start Date',
                labelStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(
                text: _startDate != null
                    ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                    : '',
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _startDate = date;
                  });
                }
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              readOnly: true,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'End Date',
                labelStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(
                text: _endDate != null
                    ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                    : '',
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? (_startDate ?? DateTime.now()),
                  firstDate: _startDate ?? DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _endDate = date;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _saveDiscount() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement discount saving logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Discount saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    _minimumAmountController.dispose();
    _maximumAmountController.dispose();
    _limitPerCustomerController.dispose();
    _totalLimitController.dispose();
    super.dispose();
  }
}