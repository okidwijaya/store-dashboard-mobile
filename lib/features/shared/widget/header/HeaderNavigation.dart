import 'package:flutter/material.dart';
import 'dart:ui';

class HeaderNavigation extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final int notificationCount;

  const HeaderNavigation({
    Key? key,
    required this.title,
    this.onSearchPressed,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  State<HeaderNavigation> createState() => _HeaderNavigationState();

  @override
  Size get preferredSize => const Size.fromHeight(80); // Fixed height
}

class _HeaderNavigationState extends State<HeaderNavigation>
    with SingleTickerProviderStateMixin {
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80 + MediaQuery.of(context).padding.top, // Fixed total height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF8FAFC),
            Color(0xFFEBF4FF),
          ],
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _showSearchBar ? _buildSearchBar() : _buildMainHeader(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainHeader() {
    return Row(
      children: [
        // Menu Button
        _buildIconButton(
          icon: Icons.menu_rounded,
          onPressed: () {
            final scaffold = Scaffold.of(context);
            if (scaffold.hasDrawer) {
              scaffold.openDrawer();
            }
          },
        ),
        
        const SizedBox(width: 12),
        
        // Logo & Title Section
        Expanded(
          child: Row(
            children: [
              // App Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.business_center_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Title Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ERP Suite',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Action Buttons Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search Button
            _buildIconButton(
              icon: Icons.search_rounded,
              onPressed: () {
                setState(() {
                  _showSearchBar = true;
                });
              },
            ),
            
            const SizedBox(width: 8),
            
            // Notifications Button
            _buildNotificationButton(),
            
            const SizedBox(width: 8),
            
            // Profile Button
            _buildProfileButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        // Back Button
        _buildIconButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () {
            setState(() {
              _showSearchBar = false;
              _searchController.clear();
            });
          },
        ),
        
        const SizedBox(width: 12),
        
        // Search Input
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9).withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE2E8F0).withOpacity(0.6),
              ),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF1E293B),
              ),
              decoration: InputDecoration(
                hintText: 'Search products, orders...',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 15,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Color(0xFF94A3B8),
                          size: 18,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) => setState(() {}),
              onSubmitted: (value) {
                widget.onSearchPressed?.call();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0).withOpacity(0.6),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC).withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE2E8F0).withOpacity(0.6),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onNotificationPressed,
                borderRadius: BorderRadius.circular(12),
                child: const Icon(
                  Icons.notifications_outlined,
                  size: 20,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
          ),
          if (widget.notificationCount > 0)
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${widget.notificationCount > 9 ? '9+' : widget.notificationCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileButton() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0).withOpacity(0.6),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onProfilePressed,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}