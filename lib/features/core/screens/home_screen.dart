import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/utils/logger.dart';
import '../../../providers/auth_notifier.dart';

/// Home screen widget
/// 
/// This is the main screen of the application, displaying the user's
/// dashboard and main functionality. It follows Apple's Human Interface
/// Guidelines for a modern, sleek design.

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.debug('[HomeScreen] Building home screen');
    
    return Scaffold(
      backgroundColor: DesignTokens.neutral100,
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  /// Builds the app bar with modern iOS-style design
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Home',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: DesignTokens.neutral900,
        ),
      ),
      backgroundColor: DesignTokens.neutral100,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: DesignTokens.neutral100,
          ),
          onPressed: () {
            // TODO: Navigate to notifications screen
            logger.debug('[HomeScreen] Notifications tapped');
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final authState = ref.watch(authNotifierProvider);
            if (authState.isAuthenticated) {
              return PopupMenuButton<String>(
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: DesignTokens.neutral900,
                ),
                onSelected: (value) async {
                  if (value == 'logout') {
                    logger.info('[HomeScreen] User logout requested');
                    await ref.read(authNotifierProvider.notifier).logout();
                    // Navigation will be handled by route guards
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline, size: 20),
                        const SizedBox(width: 8),
                        Text(authState.displayName),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Logout', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  /// Builds the main body content
  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    // Show loading if authentication is still being checked
    if (authState.status == AuthStatus.unknown) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context, authState),
          const SizedBox(height: 24),
          _buildQuickActionsSection(context, ref),
          const SizedBox(height: 24),
          _buildStatsSection(context),
          const SizedBox(height: 24),
          _buildRecentActivitySection(context),
        ],
      ),
    );
  }

  /// Builds the welcome section with user greeting
  Widget _buildWelcomeSection(BuildContext context, AuthState authState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DesignTokens.neutral100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: DesignTokens.neutral200,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: DesignTokens.neutral900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            authState.isAuthenticated ? authState.displayName : 'Guest',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: DesignTokens.neutral700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Ready to get started?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: DesignTokens.neutral900,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the quick actions section
  Widget _buildQuickActionsSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: DesignTokens.neutral900,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.add_circle_outline,
                title: 'Create New',
                subtitle: 'Start something new',
                onTap: () {
                  logger.debug('[HomeScreen] Create New tapped');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.search_outlined,
                title: 'Search',
                subtitle: 'Find what you need',
                onTap: () {
                  logger.debug('[HomeScreen] Search tapped');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the stats section
  Widget _buildStatsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: DesignTokens.neutral900,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DesignTokens.neutral100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: DesignTokens.neutral200,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(context, '0', 'Total Items'),
              _buildStatItem(context, '0', 'Completed'),
              _buildStatItem(context, '0', 'In Progress'),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the recent activity section
  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: DesignTokens.neutral900,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DesignTokens.neutral100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: DesignTokens.neutral200,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                context,
                icon: Icons.check_circle_outline,
                title: 'No recent activity',
                subtitle: 'Your activity will appear here',
                color: DesignTokens.neutral700,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds an action card
  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: DesignTokens.neutral100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: DesignTokens.neutral200,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: DesignTokens.primary900,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: DesignTokens.neutral900,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: DesignTokens.neutral700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a stat item
  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: DesignTokens.primary900,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: DesignTokens.neutral700,
          ),
        ),
      ],
    );
  }

  /// Builds an activity item
  Widget _buildActivityItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: color,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: DesignTokens.neutral900,
                ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: DesignTokens.neutral700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
