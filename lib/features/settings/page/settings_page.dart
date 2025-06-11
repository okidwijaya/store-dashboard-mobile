import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Form controllers
  final TextEditingController _prefixController = TextEditingController(text: '#');
  final TextEditingController _suffixController = TextEditingController();
  
  // Dropdown values
  String _selectedRegion = 'Indonesia';
  String _selectedUnitSystem = 'Metric system';
  String _selectedWeightUnit = 'Kilogram (kg)';
  String _selectedTimeZone = '(GMT-05:00) Eastern Time (US & Canada)';
  
  // Radio button values
  String _orderProcessing = 'manual';
  bool _autoArchive = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _prefixController.dispose();
    _suffixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStoreDetailsCard(),
                const SizedBox(height: 20),
                _buildStoreDefaultsCard(),
                const SizedBox(height: 20),
                _buildOrderIdCard(),
                const SizedBox(height: 20),
                _buildOrderProcessingCard(),
                const SizedBox(height: 20),
                _buildBrandAssetsCard(),
                const SizedBox(height: 20),
                _buildResourcesCard(),
                const SizedBox(height: 40), // Extra bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreDetailsCard() {
    return _buildCard(
      title: 'Store details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection(
            title: 'Quickstart (e2b0e499)',
            subtitle: 'okidwijaya@gmail.com • No phone number',
            icon: Icons.store,
          ),
          const SizedBox(height: 16),
          _buildInfoSection(
            title: 'Billing address:',
            subtitle: 'Jl. Gerilya, Tanjung, Purwokerto, Central Java 53171, Indonesia',
            icon: Icons.location_on,
          ),
        ],
      ),
    );
  }

  Widget _buildStoreDefaultsCard() {
    return _buildCard(
      title: 'Store defaults',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownRow(
            label: 'Currency display',
            value: 'Indonesian Rupiah (IDR Rp)',
            hasAction: true,
            actionText: 'Markets',
            onActionTap: () => _showSnackBar('Markets opened'),
          ),
          const SizedBox(height: 24),
          _buildDropdownField(
            label: 'Backup Region',
            value: _selectedRegion,
            items: ['Indonesia', 'Malaysia', 'Singapore', 'Thailand'],
            onChanged: (value) => setState(() => _selectedRegion = value!),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: _buildDropdownField(
                  label: 'Unit system',
                  value: _selectedUnitSystem,
                  items: ['Metric system', 'Imperial system'],
                  onChanged: (value) => setState(() => _selectedUnitSystem = value!),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: _buildDropdownField(
                  label: 'Default weight unit',
                  value: _selectedWeightUnit,
                  items: ['Kilogram (kg)', 'Gram (g)', 'Pound (lb)', 'Ounce (oz)'],
                  onChanged: (value) => setState(() => _selectedWeightUnit = value!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDropdownField(
            label: 'Time zone',
            value: _selectedTimeZone,
            items: [
              '(GMT-05:00) Eastern Time (US & Canada)',
              '(GMT+07:00) Western Indonesia Time',
              '(GMT+08:00) Central Indonesia Time',
            ],
            onChanged: (value) => setState(() => _selectedTimeZone = value!),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: Text(
              'Sets the time for when orders and analytics are recorded. To change user level time zone and language visit your account settings',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderIdCard() {
    return _buildCard(
      title: 'Order ID',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Prefix',
                  controller: _prefixController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Suffix',
                  controller: _suffixController,
                  hintText: 'Optional',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Your order ID will appear as #1001, #1002, #1003 ...',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProcessingCard() {
    return _buildCard(
      title: 'Order processing',
      child: Column(
        children: [
          _buildRadioOption(
            title: 'Automatically fulfill the order\'s line items',
            value: 'auto_all',
            groupValue: _orderProcessing,
            onChanged: (value) => setState(() => _orderProcessing = value!),
          ),
          _buildRadioOption(
            title: 'Automatically fulfill only the gift cards of the order',
            value: 'auto_gift',
            groupValue: _orderProcessing,
            onChanged: (value) => setState(() => _orderProcessing = value!),
          ),
          _buildRadioOption(
            title: 'Don\'t fulfill any of the order\'s line items automatically',
            value: 'manual',
            groupValue: _orderProcessing,
            onChanged: (value) => setState(() => _orderProcessing = value!),
          ),
          const SizedBox(height: 20),
          _buildCheckboxOption(
            title: 'Automatically archive the order',
            subtitle: 'The order will be removed from your list of open orders.',
            value: _autoArchive,
            onChanged: (value) => setState(() => _autoArchive = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandAssetsCard() {
    return _buildCard(
      title: 'Brand assets',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Integrate brand assets across sales channels, themes, and apps',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showSnackBar('Brand assets management opened'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Manage',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesCard() {
    return _buildCard(
      title: 'Resources',
      child: Column(
        children: [
          _buildResourceItem(
            title: 'Change log',
            action: 'View change log',
            onTap: () => _showSnackBar('Change log opened'),
          ),
          _buildDivider(),
          _buildResourceItem(
            title: 'Shopify Help Center',
            action: 'Get help',
            onTap: () => _showSnackBar('Help center opened'),
          ),
          _buildDivider(),
          _buildResourceItem(
            title: 'Hire a Shopify Partner',
            action: 'Hire a Partner',
            onTap: () => _showSnackBar('Partner hiring opened'),
          ),
          _buildDivider(),
          _buildExpandableItem(
            title: 'Keyboard shortcuts',
            onTap: () => _showSnackBar('Keyboard shortcuts opened'),
          ),
          _buildDivider(),
          _buildExpandableItem(
            title: 'Store activity log',
            onTap: () => _showSnackBar('Activity log opened'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF3B82F6),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required String value,
    bool hasAction = false,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        if (hasAction && actionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3B82F6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1F2937),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRadioOption({
    required String title,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: const Color(0xFF3B82F6),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: value,
              onChanged: (val) => onChanged(val!),
              activeColor: const Color(0xFF3B82F6),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem({
    required String title,
    required String action,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
            Text(
              action,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3B82F6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
    );
  }

  void _showSnackBar(String message) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}