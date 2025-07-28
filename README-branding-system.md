# سیستم مدیریت Branding Data

این سیستم به شما امکان می‌دهد تا اطلاعات برندینگ (عنوان، شعار، رنگ اصلی) را در کل اپلیکیشن ذخیره کرده و از آن استفاده کنید.

## ساختار فایل‌ها

### 1. `lib/services/branding_service.dart`
- سرویس اصلی برای بارگذاری و ذخیره اطلاعات برندینگ
- از الگوی Singleton استفاده می‌کند
- اطلاعات را در حافظه و SharedPreferences ذخیره می‌کند

### 2. `lib/services/branding_bloc.dart`
- مدیریت state برای اطلاعات برندینگ
- از BLoC pattern استفاده می‌کند
- امکان بارگذاری، بروزرسانی و پاک کردن cache

### 3. `lib/widgets/branding_display.dart`
- Widget آماده برای نمایش اطلاعات برندینگ
- Helper class برای دسترسی آسان به اطلاعات

### 4. `lib/utility/branding_usage_examples.dart`
- مثال‌های مختلف استفاده از سیستم برندینگ

## نحوه استفاده

### 1. بارگذاری اطلاعات برندینگ

```dart
// در initState یا هر جای دیگر
context.read<BrandingBloc>().add(LoadBrandingData());
```

### 2. استفاده در Widget با BlocBuilder

```dart
BlocBuilder<BrandingBloc, BrandingState>(
  builder: (context, state) {
    if (state is BrandingLoaded) {
      final brandingData = state.data;
      return Text(
        brandingData.name, // یا brandingData.title برای backward compatibility
        style: TextStyle(
          color: hexToColor(brandingData.primaryColorHex),
        ),
      );
    }
    return CircularProgressIndicator();
  },
)
```

### 3. استفاده از BrandingDataHelper

```dart
// دریافت رنگ اصلی
Color primaryColor = BrandingDataHelper.getPrimaryColor(context);

// دریافت رنگ ثانویه
Color secondaryColor = BrandingDataHelper.getSecondaryColor(context);

// دریافت عنوان
String title = BrandingDataHelper.getTitle(context);

// دریافت شعار
String slogan = BrandingDataHelper.getSlogan(context);

// دریافت tone
String tone = BrandingDataHelper.getTone(context);

// دریافت focus area
String focusArea = BrandingDataHelper.getFocusArea(context);
```

### 4. استفاده از Widget آماده

```dart
// نمایش کامل اطلاعات برندینگ
BrandingDisplay()

// دکمه بروزرسانی
BrandingRefreshButton()
```

### 5. بروزرسانی اطلاعات

```dart
// بروزرسانی از سرور
context.read<BrandingBloc>().add(RefreshBrandingData());

// پاک کردن cache
context.read<BrandingBloc>().add(ClearBrandingData());
```

## مثال‌های کاربردی

### استفاده در AppBar

```dart
AppBar(
  backgroundColor: BrandingDataHelper.getPrimaryColor(context),
  title: Text(BrandingDataHelper.getTitle(context)),
  actions: [BrandingRefreshButton()],
)
```

### استفاده در Theme

```dart
Theme(
  data: Theme.of(context).copyWith(
    primaryColor: BrandingDataHelper.getPrimaryColor(context),
  ),
  child: YourWidget(),
)
```

### استفاده در Container

```dart
Container(
  color: BrandingDataHelper.getPrimaryColor(context).withOpacity(0.1),
  child: Text(
    BrandingDataHelper.getSlogan(context),
    style: TextStyle(
      color: BrandingDataHelper.getPrimaryColor(context),
    ),
  ),
)
```

## مزایای این سیستم

1. **دسترسی آسان**: در هر جای اپلیکیشن می‌توانید به اطلاعات برندینگ دسترسی داشته باشید
2. **Cache هوشمند**: اطلاعات در حافظه و SharedPreferences ذخیره می‌شود
3. **بروزرسانی آسان**: امکان بروزرسانی اطلاعات از سرور
4. **Widget آماده**: کامپوننت‌های آماده برای استفاده سریع
5. **Helper Classes**: کلاس‌های کمکی برای دسترسی آسان
6. **State Management**: مدیریت state با BLoC pattern

## نکات مهم

- اطلاعات برندینگ در `main.dart` به عنوان BlocProvider اضافه شده است
- در `mainScreen.dart` اطلاعات در `initState` بارگذاری می‌شود
- از `equatable` برای مقایسه state ها استفاده می‌شود
- اطلاعات در SharedPreferences ذخیره می‌شود تا در بارگذاری بعدی سریع‌تر باشد 