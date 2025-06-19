import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedPeriod = 'This Month';
  final List<String> _timePeriods = ['Today', 'This Week', 'This Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Analytics',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedPeriod,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              items: _timePeriods.map((String period) {
                return DropdownMenuItem<String>(
                  value: period,
                  child: Text(period),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedPeriod = newValue;
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            SizedBox(height: 24),
            _buildSalesChart(),
            SizedBox(height: 24),
            _buildTopProducts(),
            SizedBox(height: 24),
            _buildRecentOrders(),
          ],
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

  Widget _buildSummaryCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Total Sales',
                value: '\$12,345',
                trend: '+12.3%',
                isPositive: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                title: 'Total Orders',
                value: '234',
                trend: '+5.2%',
                isPositive: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Average Order Value',
                value: '\$52.75',
                trend: '-2.1%',
                isPositive: false,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                title: 'Conversion Rate',
                value: '3.2%',
                trend: '+0.8%',
                isPositive: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
    required bool isPositive,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
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
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return _buildCard(
      title: 'Sales Overview',
      child: Container(
        height: 300,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(1, 4),
                  FlSpot(2, 3.5),
                  FlSpot(3, 5),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 5.5),
                ],
                isCurved: true,
                color: Color(0xFF2563EB),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Color(0xFF2563EB).withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopProducts() {
    return _buildCard(
      title: 'Top Products',
      child: Column(
        children: [
          _buildProductRow(
            name: 'T-Shirt',
            sold: 125,
            revenue: 3725.00,
            growth: 12.3,
          ),
          Divider(),
          _buildProductRow(
            name: 'Jeans',
            sold: 98,
            revenue: 5880.00,
            growth: 8.7,
          ),
          Divider(),
          _buildProductRow(
            name: 'Sneakers',
            sold: 87,
            revenue: 7830.00,
            growth: -2.4,
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow({
    required String name,
    required int sold,
    required double revenue,
    required double growth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(name, style: TextStyle(fontSize: 14)),
          ),
          Expanded(
            child: Text('${sold}', style: TextStyle(fontSize: 14)),
          ),
          Expanded(
            child: Text(
              '\$${revenue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            width: 80,
            child: Text(
              '${growth >= 0 ? '+' : ''}${growth.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 14,
                color: growth >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrders() {
    return _buildCard(
      title: 'Recent Orders',
      child: Column(
        children: [
          _buildOrderRow(
            orderId: '#12345',
            customer: 'John Doe',
            amount: 149.99,
            status: 'Completed',
          ),
          Divider(),
          _buildOrderRow(
            orderId: '#12344',
            customer: 'Jane Smith',
            amount: 89.99,
            status: 'Processing',
          ),
          Divider(),
          _buildOrderRow(
            orderId: '#12343',
            customer: 'Bob Johnson',
            amount: 199.99,
            status: 'Completed',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderRow({
    required String orderId,
    required String customer,
    required double amount,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(orderId, style: TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 2,
            child: Text(customer, style: TextStyle(fontSize: 14)),
          ),
          Expanded(
            child: Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Completed' ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 14,
                color: status == 'Completed' ? Colors.green : Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}