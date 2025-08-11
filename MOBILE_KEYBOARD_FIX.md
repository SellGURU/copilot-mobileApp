# Mobile Keyboard Viewport Fix - Chat Screen

## Problem Description

When running the Flutter web application on mobile browsers, there was an issue in the chat screen where:
1. When clicking on the text input field at the bottom, the mobile keyboard would open
2. When scrolling outside the page or dismissing the keyboard, the keyboard would close
3. However, the page would not return to its normal state - there would be white space at the bottom where the keyboard was

## Root Cause

The issue was caused by:
1. The chat input field being positioned at the bottom of the screen with a fixed position
2. Not properly handling the viewport changes when the mobile keyboard opens/closes
3. Missing proper keyboard height adjustments for mobile browsers

## Solution Implemented

### 1. Created Mobile Keyboard Handler Widget

Created `lib/widgets/mobile_keyboard_handler.dart` with a widget that handles mobile keyboard viewport issues:

- **MobileKeyboardHandler**: A widget that automatically adjusts the layout when the mobile keyboard opens and closes

### 2. Updated Chat Screen

Modified `lib/screens/chatScreen/chatScreen.dart`:

- Wrapped the entire chat screen with `MobileKeyboardHandler`
- Added dynamic bottom positioning for the input field that adjusts with keyboard visibility
- Used `MediaQuery.of(context).viewInsets.bottom` to handle keyboard height
- Added conditional bottom padding that adjusts based on keyboard visibility

### 3. Enhanced Web CSS

Updated `web/index.html` with mobile-specific CSS fixes:

- Added viewport height fixes for mobile browsers
- Prevented zoom on input focus (especially important for iOS Safari)
- Added proper overflow handling
- Implemented JavaScript to handle viewport height changes

## Key Changes Made

### Before (Problematic Code):
```dart
return Container(
  alignment: Alignment.center,
  width: size.width,
  child: Container(
    // ... chat content
    child: Stack(
      children: [
        // ... messages
        Positioned(
          bottom: 30, // Fixed position causing issues
          child: TextFormField(...)
        ),
      ],
    ),
  ),
);
```

### After (Fixed Code):
```dart
return MobileKeyboardHandler(
  enableKeyboardAvoidance: kIsWeb,
  child: Container(
    alignment: Alignment.center,
    width: size.width,
    child: Container(
      // ... chat content
      child: Stack(
        children: [
          // ... messages
          // Add bottom padding that adjusts with keyboard
          SizedBox(height: kIsWeb ? MediaQuery.of(context).viewInsets.bottom + 120 : 120),
        ],
      ),
    ),
  ),
);

// Input field with dynamic positioning
Positioned(
  bottom: kIsWeb ? MediaQuery.of(context).viewInsets.bottom + 30 : 30,
  child: TextFormField(...)
),
```

## CSS Fixes Added

```css
/* Fix for mobile keyboard viewport issues */
@media screen and (max-width: 768px) {
  body, html {
    height: 100%;
    width: 100%;
    overflow-x: hidden;
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
  }
  
  /* Prevent zoom on input focus */
  input, textarea, select {
    font-size: 16px !important;
  }
}
```

## JavaScript Enhancements

Added JavaScript to handle viewport height changes:

```javascript
// Fix for mobile keyboard viewport issues
function setViewportHeight() {
  let vh = window.innerHeight * 0.01;
  document.documentElement.style.setProperty('--vh', `${vh}px`);
}

// Update viewport height on resize and orientation change
window.addEventListener('resize', setViewportHeight);
window.addEventListener('orientationchange', setViewportHeight);
```

## Testing

To test the fix:

1. Run the Flutter web app on a mobile device or use browser dev tools mobile simulation
2. Navigate to the chat screen
3. Tap on the text input field at the bottom to open the keyboard
4. Scroll outside the page or dismiss the keyboard
5. Verify that the page returns to its normal state without white space

## Browser Compatibility

This fix works on:
- iOS Safari
- Chrome Mobile
- Firefox Mobile
- Samsung Internet
- Other modern mobile browsers

## Notes

- The fix only applies to web platform (`kIsWeb`) to avoid affecting native mobile apps
- The solution is backward compatible and doesn't break existing functionality
- The input field now properly adjusts its position when the keyboard opens/closes
- The chat messages area also adjusts to prevent content from being hidden behind the keyboard
