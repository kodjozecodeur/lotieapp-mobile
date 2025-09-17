# 🧩 Component Library

This document provides a comprehensive overview of the component library used in the Lotie App Flutter project.

## 📋 Overview

The component library consists of reusable UI components that follow the design system and ensure consistency across the application. Components are organized into different categories based on their purpose and complexity.

## 🏗️ Component Categories

### 1. Core Components
Basic, foundational components that other components build upon.

### 2. Figma Components
Components specifically designed to match Figma designs exactly.

### 3. Custom Widgets
Application-specific components that extend Flutter's built-in widgets.

### 4. Animation Components
Components that include animations and transitions.

## 🎯 Core Components

### CustomButton
A customizable button component with multiple variants and sizes.

**Location**: `lib/core/widgets/custom_button.dart`

**Features**:
- Multiple button styles (primary, secondary, outline, text)
- Different sizes (small, medium, large)
- Loading states
- Icon support
- Customizable colors and styling

**Usage**:
```dart
CustomButton(
  text: 'Click Me',
  onPressed: () => print('Button pressed'),
  style: CustomButtonStyle.primary,
  size: ButtonSize.medium,
  isExpanded: true,
)
```

### CustomTextField
A comprehensive text input component with validation and styling.

**Location**: `lib/core/widgets/custom_text_field.dart`

**Features**:
- Multiple input types (text, email, password, phone, username)
- Validation support
- Error states
- Prefix and suffix icons
- Character counting
- Custom styling

**Usage**:
```dart
CustomTextField(
  label: 'Email',
  hint: 'Enter your email',
  type: TextFieldType.email,
  validator: (value) => Validators.isValidEmail(value) ? null : 'Invalid email',
  onChanged: (value) => print('Email: $value'),
)
```

## 🎨 Figma Components

### FigmaButton
A button component designed to match Figma specifications exactly.

**Location**: `lib/core/widgets/figma_components/figma_button.dart`

**Features**:
- Exact Figma design implementation
- Design token integration
- Responsive sizing
- Multiple variants and states

**Usage**:
```dart
FigmaButton(
  text: 'Submit',
  variant: FigmaButtonVariant.primary,
  size: FigmaButtonSize.medium,
  onPressed: () => print('Submitted'),
)
```

### FigmaCard
A card component with header, content, and footer sections.

**Location**: `lib/core/widgets/figma_components/figma_card.dart`

**Features**:
- Multiple card variants (elevated, outlined, filled, ghost)
- Header, content, and footer sections
- Clickable support
- Custom styling options

**Usage**:
```dart
FigmaCard(
  variant: FigmaCardVariant.elevated,
  child: FigmaCardHeader(
    title: 'Card Title',
    subtitle: 'Card subtitle',
    action: IconButton(icon: Icon(Icons.more_vert)),
  ),
)
```

### FigmaInput
An input component designed to match Figma specifications.

**Location**: `lib/core/widgets/figma_components/figma_input.dart`

**Features**:
- Figma-accurate styling
- Multiple input types and states
- Design token integration
- Responsive design

**Usage**:
```dart
FigmaInput(
  label: 'Username',
  hint: 'Enter username',
  type: FigmaInputType.text,
  size: FigmaInputSize.medium,
  state: FigmaInputState.normal,
  onChanged: (value) => print('Username: $value'),
)
```

## 🎭 Animation Components

### AnimatedCard
A card component with built-in animations.

**Features**:
- Fade-in animation
- Scale animation
- Staggered animations
- Custom animation durations

### AnimatedButton
A button component with hover and press animations.

**Features**:
- Press animation
- Hover effects
- Loading animations
- Success/error animations

## 📱 Responsive Components

### ResponsiveContainer
A container that adapts to different screen sizes.

**Features**:
- Breakpoint-based sizing
- Responsive padding and margins
- Adaptive layouts
- Mobile-first design

### ResponsiveGrid
A grid component that adjusts columns based on screen size.

**Features**:
- Dynamic column count
- Responsive spacing
- Adaptive item sizing
- Mobile optimization

## 🎨 Styling Components

### ThemeCard
A card component that automatically adapts to the current theme.

**Features**:
- Light/dark theme support
- Automatic color adaptation
- Theme-aware shadows
- Consistent styling

### GradientContainer
A container with gradient background support.

**Features**:
- Multiple gradient types
- Custom color stops
- Animation support
- Responsive gradients

## 🔧 Utility Components

### LoadingOverlay
A full-screen loading overlay component.

**Features**:
- Customizable loading indicator
- Blur background
- Dismissible option
- Custom messages

### ErrorBoundary
A component that catches and displays errors gracefully.

**Features**:
- Error catching
- Fallback UI
- Error reporting
- Recovery options

## 📊 Data Display Components

### DataTable
A responsive data table component.

**Features**:
- Sortable columns
- Filtering support
- Pagination
- Responsive design

### ChartContainer
A container for displaying charts and graphs.

**Features**:
- Multiple chart types
- Interactive charts
- Responsive sizing
- Custom styling

## 🧪 Component Testing

### Unit Tests
Each component has comprehensive unit tests covering:
- Rendering
- User interactions
- State changes
- Error handling

### Widget Tests
Widget tests verify:
- Visual appearance
- User interactions
- Accessibility
- Responsive behavior

### Integration Tests
Integration tests ensure:
- Component interactions
- End-to-end functionality
- Performance
- Cross-platform compatibility

## 📚 Usage Guidelines

### Component Selection
1. **Core Components**: Use for basic UI needs
2. **Figma Components**: Use when exact design match is required
3. **Custom Widgets**: Use for application-specific needs
4. **Animation Components**: Use when animations are needed

### Best Practices
1. **Consistency**: Use design tokens for all styling
2. **Accessibility**: Ensure components are accessible
3. **Performance**: Optimize for smooth performance
4. **Testing**: Write comprehensive tests
5. **Documentation**: Document all props and usage

### Customization
1. **Design Tokens**: Use design tokens for consistent styling
2. **Props**: Use props for customization
3. **Theming**: Support theme changes
4. **Responsive**: Ensure responsive behavior

## 🔄 Component Development

### Creating New Components
1. **Design**: Start with Figma design or requirements
2. **Implementation**: Create component following patterns
3. **Testing**: Write comprehensive tests
4. **Documentation**: Document usage and props
5. **Integration**: Add to component library

### Updating Components
1. **Version Control**: Use semantic versioning
2. **Breaking Changes**: Document breaking changes
3. **Migration**: Provide migration guides
4. **Testing**: Update tests for changes

## 📁 File Organization

```
lib/core/widgets/
├── custom_button.dart           # Core button component
├── custom_text_field.dart       # Core input component
├── figma_components/            # Figma-specific components
│   ├── figma_button.dart
│   ├── figma_card.dart
│   └── figma_input.dart
├── animation_components/        # Animated components
│   ├── animated_card.dart
│   └── animated_button.dart
├── responsive_components/       # Responsive components
│   ├── responsive_container.dart
│   └── responsive_grid.dart
└── utility_components/          # Utility components
    ├── loading_overlay.dart
    └── error_boundary.dart
```

## 📚 Related Documentation

- [Design Tokens](./design-tokens.md)
- [Core Components](./core-components.md)
- [Figma Components](./figma-components.md)
- [Figma Integration Guide](../guides/figma-integration.md)
- [UI Guidelines](../guides/ui-guidelines.md)

---

*The component library ensures consistency, reusability, and maintainability across the entire application.*
