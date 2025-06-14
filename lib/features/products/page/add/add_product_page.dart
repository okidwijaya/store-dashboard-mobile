import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'Short sleeve t-shirt');
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController(text: '0.00');
  final _compareAtPriceController = TextEditingController(text: '0.00');
  final _costController = TextEditingController(text: '0.00');
  final _typeController = TextEditingController();
  final _vendorController = TextEditingController();
  final _collectionsController = TextEditingController();
  final _tagsController = TextEditingController();
  final _quantityController = TextEditingController(text: '0');
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _weightController = TextEditingController(text: '0.0');
  final _snowboardLengthController = TextEditingController();
  final _snowboardBindingController = TextEditingController();

  String _selectedStatus = 'Active';
  String _selectedCategory = 'Choose a product category';
  String _selectedThemeTemplate = 'Default product';
  String _selectedWeightUnit = 'kg';
  bool _chargeTax = false;
  bool _isExpanded = true;
  bool _trackQuantity = true;
  bool _continueSellingOutOfStock = false;
  bool _isPhysicalProduct = true;

  final List<String> _statusOptions = ['Active', 'Draft', 'Archived'];
  final List<String> _themeTemplateOptions = ['Default product', 'Custom template', 'Minimal template'];
  final List<String> _weightUnits = ['kg', 'g', 'lb', 'oz'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black87),
        title: Text(
          'Add product',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: _saveProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildStatusCard(),
                SizedBox(height: 16),
                _buildProductDetailsCard(),
                SizedBox(height: 16),
                _buildMediaCard(),
                SizedBox(height: 16),
                _buildProductOrganizationCard(),
                SizedBox(height: 16),
                _buildCategoryCard(),
                SizedBox(height: 16),
                _buildPricingCard(),
                SizedBox(height: 16),
                _buildInventoryCard(),
                SizedBox(height: 16),
                _buildShippingCard(),
                SizedBox(height: 16),
                _buildVariantsCard(),
                SizedBox(height: 16),
                _buildPurchaseOptionsCard(),
                SizedBox(height: 16),
                _buildThemeTemplateCard(),
                SizedBox(height: 16),
                _buildMetafieldsCard(),
                SizedBox(height: 16),
                _buildSearchEngineListingCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetailsCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: ExpansionTile(
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        leading: Icon(
          _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
          color: Colors.black54,
        ),
        title: Text(
          'Add product',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Title'),
                SizedBox(height: 8),
                _buildTextField(
                  controller: _titleController,
                  hintText: 'Short sleeve t-shirt',
                ),
                SizedBox(height: 16),
                _buildLabel('Description'),
                SizedBox(height: 8),
                _buildRichTextEditor(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaCard() {
    return _buildCard(
      title: 'Media',
      child: Container(
        constraints: BoxConstraints(maxHeight: 200),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Upload new',
                      style: TextStyle(color: Color(0xFF2563EB)),
                    ),
                  ),
                  Text(' or ', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Select existing',
                      style: TextStyle(color: Color(0xFF2563EB)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Accepts images, videos, or 3D models',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard() {
    return _buildCard(
      title: 'Category',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(
            value: _selectedCategory,
            items: ['Choose a product category', 'Clothing', 'Electronics', 'Books'],
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          SizedBox(height: 8),
          Text(
            'Determines tax rates and aids metafields to improve search, filters, and cross-channel sales',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard() {
    return _buildCard(
      title: 'Pricing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Price'),
          SizedBox(height: 8),
          _buildTextField(
            controller: _priceController,
            hintText: 'Rp 0.00',
            keyboardType: TextInputType.number,
            prefixText: 'Rp ',
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildLabel('Compare-at price'),
              SizedBox(width: 8),
              Icon(Icons.info_outline, size: 16, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          _buildTextField(
            controller: _compareAtPriceController,
            hintText: 'Rp 0.00',
            keyboardType: TextInputType.number,
            prefixText: 'Rp ',
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _chargeTax,
                onChanged: (value) {
                  setState(() {
                    _chargeTax = value!;
                  });
                },
                activeColor: Color(0xFF2563EB),
              ),
              Expanded(child: Text('Charge tax on this product')),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildLabel('Cost per item'),
              SizedBox(width: 8),
              Icon(Icons.info_outline, size: 16, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          _buildTextField(
            controller: _costController,
            hintText: 'Rp 0.00',
            keyboardType: TextInputType.number,
            prefixText: 'Rp ',
          ),
          SizedBox(height: 16),
          _buildLabel('Profit'),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFF9FAFB),
            ),
            child: Text('--', style: TextStyle(color: Colors.grey)),
          ),
          SizedBox(height: 16),
          _buildLabel('Margin'),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFF9FAFB),
            ),
            child: Text('--', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return _buildCard(
      title: 'Status',
      child: _buildDropdown(
        value: _selectedStatus,
        items: _statusOptions,
        onChanged: (value) {
          setState(() {
            _selectedStatus = value!;
          });
        },
      ),
    );
  }

  Widget _buildProductOrganizationCard() {
    return _buildCard(
      title: 'Product organization',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Type'),
          SizedBox(height: 8),
          _buildTextField(controller: _typeController),
          SizedBox(height: 16),
          _buildLabel('Vendor'),
          SizedBox(height: 8),
          _buildTextField(controller: _vendorController),
          SizedBox(height: 16),
          _buildLabel('Collections'),
          SizedBox(height: 8),
          _buildTextField(controller: _collectionsController),
          SizedBox(height: 16),
          _buildLabel('Tags'),
          SizedBox(height: 8),
          _buildTextField(controller: _tagsController),
        ],
      ),
    );
  }

  Widget _buildThemeTemplateCard() {
    return _buildCard(
      title: 'Theme template',
      child: _buildDropdown(
        value: _selectedThemeTemplate,
        items: _themeTemplateOptions,
        onChanged: (value) {
          setState(() {
            _selectedThemeTemplate = value!;
          });
        },
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    String? prefixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildRichTextEditor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFF9FAFB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E7EB)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: 'Paragraph',
                    items: ['Paragraph', 'Heading 1', 'Heading 2']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                    underline: SizedBox(),
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  SizedBox(width: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildToolbarButton(Icons.format_bold),
                      _buildToolbarButton(Icons.format_italic),
                      _buildToolbarButton(Icons.format_underlined),
                      _buildToolbarButton(Icons.format_align_left),
                      _buildToolbarButton(Icons.link),
                      _buildToolbarButton(Icons.image),
                      _buildToolbarButton(Icons.format_list_bulleted),
                      _buildToolbarButton(Icons.more_horiz),
                      _buildToolbarButton(Icons.code),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Enter product description...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(IconData icon) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Icon(icon, size: 16, color: Colors.black54),
      ),
    );
  }

  Widget _buildInventoryCard() {
    return _buildCard(
      title: 'Inventory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: _trackQuantity,
                onChanged: (value) {
                  setState(() {
                    _trackQuantity = value!;
                  });
                },
                activeColor: Color(0xFF2563EB),
              ),
              Expanded(child: Text('Track quantity')),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel('Quantity'),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit locations',
                  style: TextStyle(color: Color(0xFF2563EB)),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Jl.Garukya, Tanjung',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          SizedBox(height: 8),
          _buildTextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _continueSellingOutOfStock,
                onChanged: (value) {
                  setState(() {
                    _continueSellingOutOfStock = value!;
                  });
                },
                activeColor: Color(0xFF2563EB),
              ),
              Expanded(
                child: Text('Continue selling when out of stock'),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildLabel('SKU (Stock Keeping Unit)'),
          SizedBox(height: 8),
          _buildTextField(controller: _skuController),
          SizedBox(height: 16),
          _buildLabel('Barcode (ISBN, UPC, GTIN, etc.)'),
          SizedBox(height: 8),
          _buildTextField(controller: _barcodeController),
        ],
      ),
    );
  }

  Widget _buildShippingCard() {
    return _buildCard(
      title: 'Shipping',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: _isPhysicalProduct,
                onChanged: (value) {
                  setState(() {
                    _isPhysicalProduct = value!;
                  });
                },
                activeColor: Color(0xFF2563EB),
              ),
              Expanded(
                child: Text('This is a physical product'),
              ),
            ],
          ),
          if (_isPhysicalProduct) ...[
            SizedBox(height: 16),
            _buildLabel('Weight'),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildTextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: _buildDropdown(
                    value: _selectedWeightUnit,
                    items: _weightUnits,
                    onChanged: (value) {
                      setState(() {
                        _selectedWeightUnit = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: Color(0xFF2563EB), size: 16),
              label: Text(
                'Add customs information',
                style: TextStyle(color: Color(0xFF2563EB)),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVariantsCard() {
    return _buildCard(
      title: 'Variants',
      child: Row(
        children: [
          Icon(Icons.add, color: Color(0xFF2563EB), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Add options like size or color',
              style: TextStyle(color: Color(0xFF2563EB)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseOptionsCard() {
    return _buildCard(
      title: 'Purchase options',
      child: Row(
        children: [
          Icon(Icons.add, color: Color(0xFF2563EB), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Subscriptions, preorders, try before you buy, and more',
              style: TextStyle(color: Color(0xFF2563EB)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetafieldsCard() {
    return _buildCard(
      title: 'Metafields',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Snowboard length'),
          SizedBox(height: 8),
          _buildTextField(controller: _snowboardLengthController),
          SizedBox(height: 16),
          _buildLabel('Snowboard binding mount'),
          SizedBox(height: 8),
          _buildTextField(controller: _snowboardBindingController),
        ],
      ),
    );
  }

  Widget _buildSearchEngineListingCard() {
    return _buildCard(
      title: 'Search engine listing',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Add a title and description to see how this product might appear in a search engine listing',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(width: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Edit',
              style: TextStyle(color: Color(0xFF2563EB)),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Handle save functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product saved successfully!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _compareAtPriceController.dispose();
    _costController.dispose();
    _typeController.dispose();
    _vendorController.dispose();
    _collectionsController.dispose();
    _tagsController.dispose();
    _quantityController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _weightController.dispose();
    _snowboardLengthController.dispose();
    _snowboardBindingController.dispose();
    super.dispose();
  }
}