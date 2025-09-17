# 🎨 Design Tokens

This document explains the design token system used in the Lotie App for consistent theming and styling.

## 📋 Overview

Design tokens are the visual design atoms of the design system — specifically, they are named entities that store visual design attributes. We use them in place of hard-coded values to maintain a scalable and consistent visual system.

## 🏗️ Token Structure

The design token system is located in `lib/core/constants/design_tokens.dart` and includes:

- **Colors**: Complete color palette with semantic naming
- **Typography**: Font families, sizes, weights, and spacing
- **Spacing**: Consistent spacing scale based on 4px grid
- **Shadows**: Elevation and depth system
- **Border Radius**: Consistent corner radius values
- **Animations**: Duration and easing curves
- **Breakpoints**: Responsive design breakpoints

## 🎨 Color Tokens

### Primary Colors
```dart
// Primary brand colors (50-900 scale)
static const Color primary50 = Color(0xFFE3F2FD);
static const Color primary100 = Color(0xFFBBDEFB);
static const Color primary200 = Color(0xFF90CAF9);
static const Color primary300 = Color(0xFF64B5F6);
static const Color primary400 = Color(0xFF42A5F5);
static const Color primary500 = Color(0xFF2196F3);  // Main brand color
static const Color primary600 = Color(0xFF1E88E5);
static const Color primary700 = Color(0xFF1976D2);
static const Color primary800 = Color(0xFF1565C0);
static const Color primary900 = Color(0xFF0D47A1);
```

### Semantic Colors
```dart
// Success colors
static const Color success50 = Color(0xFFE8F5E8);
static const Color success500 = Color(0xFF4CAF50);
static const Color success700 = Color(0xFF388E3C);

// Error colors
static const Color error50 = Color(0xFFFFEBEE);
static const Color error500 = Color(0xFFF44336);
static const Color error700 = Color(0xFFD32F2F);

// Warning colors
static const Color warning50 = Color(0xFFFFF3E0);
static const Color warning500 = Color(0xFFFF9800);
static const Color warning700 = Color(0xFFF57C00);
```

### Neutral Colors
```dart
// Neutral grayscale
static const Color neutral50 = Color(0xFFFAFAFA);
static const Color neutral100 = Color(0xFFF5F5F5);
static const Color neutral200 = Color(0xFFEEEEEE);
static const Color neutral300 = Color(0xFFE0E0E0);
static const Color neutral400 = Color(0xFFBDBDBD);
static const Color neutral500 = Color(0xFF9E9E9E);
static const Color neutral600 = Color(0xFF757575);
static const Color neutral700 = Color(0xFF616161);
static const Color neutral800 = Color(0xFF424242);
static const Color neutral900 = Color(0xFF212121);
```

## 📝 Typography Tokens

### Font Families
```dart
static const String fontFamilyPrimary = 'SF Pro Display';
static const String fontFamilySecondary = 'SF Pro Text';
static const String fontFamilyMono = 'SF Mono';
```

### Font Weights
```dart
static const FontWeight fontWeightLight = FontWeight.w300;
static const FontWeight fontWeightRegular = FontWeight.w400;
static const FontWeight fontWeightMedium = FontWeight.w500;
static const FontWeight fontWeightSemiBold = FontWeight.w600;
static const FontWeight fontWeightBold = FontWeight.w700;
static const FontWeight fontWeightHeavy = FontWeight.w800;
```

### Font Sizes
```dart
static const double fontSizeXs = 12.0;    // Small text
static const double fontSizeSm = 14.0;    // Body small
static const double fontSizeBase = 16.0;  // Body text
static const double fontSizeLg = 18.0;    // Large text
static const double fontSizeXl = 20.0;    // Heading small
static const double fontSize2xl = 24.0;   // Heading medium
static const double fontSize3xl = 30.0;   // Heading large
static const double fontSize4xl = 36.0;   // Display small
static const double fontSize5xl = 48.0;   // Display medium
static const double fontSize6xl = 60.0;   // Display large
```

### Line Heights
```dart
static const double lineHeightTight = 1.2;    // Tight spacing
static const double lineHeightNormal = 1.4;   // Normal spacing
static const double lineHeightRelaxed = 1.6;  // Relaxed spacing
static const double lineHeightLoose = 1.8;    // Loose spacing
```

## 📏 Spacing Tokens

### Spacing Scale (4px grid system)
```dart
static const double space0 = 0.0;     // No spacing
static const double space1 = 4.0;     // Extra small
static const double space2 = 8.0;     // Small
static const double space3 = 12.0;    // Medium small
static const double space4 = 16.0;    // Medium
static const double space5 = 20.0;    // Medium large
static const double space6 = 24.0;    // Large
static const double space8 = 32.0;    // Extra large
static const double space10 = 40.0;   // 2x large
static const double space12 = 48.0;   // 3x large
static const double space16 = 64.0;   // 4x large
static const double space20 = 80.0;   // 5x large
static const double space24 = 96.0;   // 6x large
static const double space32 = 128.0;  // 8x large
```

## 🔲 Border Radius Tokens

```dart
static const double radiusNone = 0.0;     // No radius
static const double radiusSm = 4.0;       // Small radius
static const double radiusBase = 8.0;     // Base radius
static const double radiusMd = 12.0;      // Medium radius
static const double radiusLg = 16.0;      // Large radius
static const double radiusXl = 20.0;      // Extra large radius
static const double radius2xl = 24.0;     // 2x large radius
static const double radius3xl = 32.0;     // 3x large radius
static const double radiusFull = 9999.0;  // Fully rounded
```

## 🌟 Shadow Tokens

### Shadow System
```dart
// Small shadow
static const List<BoxShadow> shadowSm = [
  BoxShadow(
    color: Color(0x0A000000),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  ),
];

// Base shadow
static const List<BoxShadow> shadowBase = [
  BoxShadow(
    color: Color(0x14000000),
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x0A000000),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: -1,
  ),
];

// Large shadow
static const List<BoxShadow> shadowLg = [
  BoxShadow(
    color: Color(0x14000000),
    offset: Offset(0, 10),
    blurRadius: 15,
    spreadRadius: -3,
  ),
  BoxShadow(
    color: Color(0x0A000000),
    offset: Offset(0, 4),
    blurRadius: 6,
    spreadRadius: -2,
  ),
];
```

## ⏱️ Animation Tokens

### Durations
```dart
static const Duration durationFast = Duration(milliseconds: 150);
static const Duration durationNormal = Duration(milliseconds: 300);
static const Duration durationSlow = Duration(milliseconds: 500);
static const Duration durationSlower = Duration(milliseconds: 700);
```

### Easing Curves
```dart
static const Curve easeInOut = Curves.easeInOut;
static const Curve easeOut = Curves.easeOut;
static const Curve easeIn = Curves.easeIn;
static const Curve easeOutBack = Curves.easeOutBack;
static const Curve easeInOutCubic = Curves.easeInOutCubic;
```

## 📱 Responsive Breakpoints

```dart
static const double breakpointSm = 640.0;   // Small screens
static const double breakpointMd = 768.0;   // Medium screens
static const double breakpointLg = 1024.0;  // Large screens
static const double breakpointXl = 1280.0;  // Extra large screens
static const double breakpoint2xl = 1536.0; // 2x large screens
```

## 🧩 Component-Specific Tokens

### Button Tokens
```dart
static const double buttonHeightSm = 32.0;
static const double buttonHeightBase = 40.0;
static const double buttonHeightLg = 48.0;
static const double buttonPaddingHorizontal = 16.0;
static const double buttonPaddingVertical = 8.0;
```

### Input Field Tokens
```dart
static const double inputHeight = 48.0;
static const double inputPaddingHorizontal = 16.0;
static const double inputPaddingVertical = 12.0;
static const double inputBorderWidth = 1.0;
```

### Card Tokens
```dart
static const double cardPadding = 16.0;
static const double cardElevation = 0.0;
static const double cardBorderRadius = 12.0;
```

## 🎯 Usage Examples

### Using Color Tokens
```dart
Container(
  color: DesignTokens.primary500,
  child: Text(
    'Hello World',
    style: TextStyle(
      color: DesignTokens.neutral50,
      fontSize: DesignTokens.fontSizeBase.sp,
    ),
  ),
)
```

### Using Spacing Tokens
```dart
Padding(
  padding: EdgeInsets.all(DesignTokens.space4.w),
  child: Column(
    children: [
      Text('Title'),
      SizedBox(height: DesignTokens.space2.h),
      Text('Subtitle'),
    ],
  ),
)
```

### Using Typography Tokens
```dart
Text(
  'Heading',
  style: TextStyle(
    fontSize: DesignTokens.fontSize2xl.sp,
    fontWeight: DesignTokens.fontWeightSemiBold,
    color: DesignTokens.neutral900,
    letterSpacing: DesignTokens.letterSpacingNormal,
  ),
)
```

## 🔄 Updating Design Tokens

### From Figma
1. Export design tokens from Figma using Figma Tokens plugin
2. Update the corresponding values in `design_tokens.dart`
3. Test the changes across all components
4. Update documentation if needed

### Manual Updates
1. Open `lib/core/constants/design_tokens.dart`
2. Update the specific token values
3. Ensure consistency across the design system
4. Test on different screen sizes

## 📚 Related Documentation

- [Component Library](./component-library.md)
- [Figma Integration Guide](../guides/figma-integration.md)
- [UI Guidelines](../guides/ui-guidelines.md)
- [Core Components](./core-components.md)

---

*Design tokens ensure consistency and maintainability across the entire application.*
