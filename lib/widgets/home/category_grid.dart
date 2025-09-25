import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/design_tokens.dart';
import '../../models/category.dart';

/// Category grid component
/// 
/// This widget displays a grid of category items with:
/// - 4 items in a single row
/// - Each item has an icon and label
/// - Page dots indicator below
/// - Proper spacing and styling
/// 
/// Categories: Promotions, Épicerie, Restaurants, Supermarché
/// All styling uses DesignTokens for consistency.
class CategoryGrid extends StatefulWidget {
  const CategoryGrid({
    super.key,
    required this.categories,
    this.onCategoryTapped,
  });

  /// List of categories to display
  final List<Category> categories;
  
  /// Callback when a category is tapped
  final Function(String categoryId)? onCategoryTapped;

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Get color from DesignTokens by name
  // Color _getColorByName(String colorName) {
  //   switch (colorName) {
  //     case 'success500':
  //       return DesignTokens.success500;
  //     case 'warning500':
  //       return DesignTokens.warning500;
  //     case 'error500':
  //       return DesignTokens.error500;
  //     case 'info500':
  //       return DesignTokens.info500;
  //     default:
  //       return DesignTokens.primary500;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Calculate number of pages (4 items per page)
    final int itemsPerPage = 4;
    final int pageCount = (widget.categories.length / itemsPerPage).ceil();

    return Column(
      children: [
        // Category grid
        SizedBox(
          height: 100.h, // Fixed height for grid
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: pageCount,
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * itemsPerPage;
              final endIndex = (startIndex + itemsPerPage).clamp(0, widget.categories.length);
              final pageCategories = widget.categories.sublist(startIndex, endIndex);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pageCategories.map((category) {
                  return _buildCategoryItem(category);
                }).toList(),
              );
            },
          ),
        ),
        
        SizedBox(height: DesignTokens.space4.h),
        
        // Page dots indicator (only show if more than 1 page)
        if (pageCount > 1) _buildPageIndicator(pageCount),
      ],
    );
  }

  /// Build individual category item
  Widget _buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () => widget.onCategoryTapped?.call(category.id),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: DesignTokens.neutral100,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                category.iconPath,
                width: 32.w,
                height: 32.h,
                // colorFilter: ColorFilter.mode(
                //   _getColorByName(category.color),
                //   BlendMode.srcIn,
                // ),
              ),
            ),
          ),
          
          SizedBox(height: DesignTokens.space2.h),
          
          // Category label
          Text(
            category.name,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXs.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: DesignTokens.neutral850,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build page dots indicator
  Widget _buildPageIndicator(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return AnimatedContainer(
          duration: DesignTokens.durationFast,
          margin: EdgeInsets.symmetric(horizontal: DesignTokens.space1.w),
          width: index == _currentPage ? 8.w : 6.w,
          height: index == _currentPage ? 8.h : 6.h,
          decoration: BoxDecoration(
            color: index == _currentPage 
                ? DesignTokens.primary700 
                : DesignTokens.neutral400,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
