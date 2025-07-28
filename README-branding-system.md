# Branding System Documentation

## Overview
This system manages dynamic branding data (colors, text, etc.) that can be loaded from a backend API and applied throughout the application.

## Architecture

### Core Components

1. **BrandingService** (`lib/services/branding_service.dart`)
   - Singleton service for loading and caching branding data
   - Handles API calls and local storage
   - Provides fallback data if API fails

2. **BrandingBloc** (`lib/services/branding_bloc.dart`)
   - State management for branding data
   - Handles loading, error, and success states
   - Provides reactive updates to UI

3. **BrandingData** (`lib/models/branding_data.dart`)
   - Data model for branding information
   - Maps to JSON response from API
   - Includes colors, text, and other branding elements

### Key Features

- **Automatic Loading**: Branding data loads automatically when the app starts
- **Caching**: Data is cached locally for offline access
- **Dynamic Colors**: Primary and secondary colors can be updated dynamically
- **Error Handling**: Fallback data provided if API fails
- **Reactive UI**: UI components automatically update when branding changes

## Usage

### Basic Usage

```dart
// Access branding data anywhere in the app
BlocBuilder<BrandingBloc, BrandingState>(
  builder: (context, state) {
    if (state is BrandingLoaded) {
      return Text(state.data.name);
    }
    return CircularProgressIndicator();
  },
)
```

### Using Dynamic Colors

```dart
// Use the dynamic primary color
Container(
  color: AppColors.dynamicPrimaryColor,
  child: Text('Styled with branding color'),
)
```

### Reactive Color Updates

```dart
// Widget that updates when color changes
ValueListenableBuilder<Color>(
  valueListenable: AppColors.dynamicPrimaryColorNotifier,
  builder: (context, color, child) {
    return Container(
      color: color,
      child: Text('Reactive color widget'),
    );
  },
)
```

## API Integration

The system expects a JSON response with this structure:

```json
{
  "brand_elements": {
    "name": "Brand Name",
    "headline": "Brand Headline",
    "primary_color": "#000000",
    "secondary_color": "#dce7ea",
    "tone": "Motivational and Supportive",
    "focus_area": "longivity"
  }
}
```

## Setup

1. **Add BlocProvider** in `main.dart`:
```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => BrandingBloc()),
    // ... other providers
  ],
  child: MyApp(),
)
```

2. **Load branding data** in your main screen:
```dart
@override
void initState() {
  super.initState();
  context.read<BrandingBloc>().add(LoadBrandingData());
}
```

## File Structure

```
lib/
├── services/
│   ├── branding_service.dart      # API and caching logic
│   └── branding_bloc.dart         # State management
├── models/
│   └── branding_data.dart         # Data model
├── utility/
│   ├── branding_helper.dart       # Utility functions
│   └── branding_color_setter.dart # Color setting utilities
└── res/
    └── colors.dart                # Dynamic color definitions
```

## Configuration

### Endpoints
Configure the branding API endpoint in `lib/constants/endPoints.dart`:
```dart
static const String brandingInfo = '/api/branding/info';
```

### Caching
Branding data is automatically cached using `shared_preferences`. Cache can be cleared programmatically:
```dart
BrandingService.instance.clearCache();
```

## Troubleshooting

### Common Issues

1. **Colors not updating**: Ensure you're using `AppColors.dynamicPrimaryColor` instead of static colors
2. **API not called**: Check network connectivity and token authentication
3. **Cache issues**: Clear cache using `BrandingService.instance.clearCache()`

### Debug Information

Check console logs for detailed information about:
- API call status
- Cache operations
- Color application
- Error messages

## Best Practices

1. **Always use reactive widgets** when displaying branding colors
2. **Handle loading states** in your UI
3. **Provide fallback colors** for error states
4. **Test with different network conditions** to ensure reliability 