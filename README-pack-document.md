### توضیحات مربوط به پکیج‌های مورد استفاده در پروژه Flutter

این فایل README توضیحاتی درباره پکیج‌های که در پروژه Flutter شما استفاده می‌شود ارایه می‌دهد. به هر پکیج و کاربرد آن مرتبط به پروژه پرداخته می‌شود.

---

#### 1. **cupertino_icons**
- کاربرد: این پکیج ایکون‌های استایل iOS (کوپرتینو) را فراهم می‌کند.
- مثال استفاده:
  ```dart
  import 'package:flutter/cupertino.dart';

  Icon(CupertinoIcons.add);
  ```

---

#### 2. **flutter_bloc**
- کاربرد: برای مدیریت حالت به صورت BLoC (مدل Business Logic Component).
- مثال استفاده:
  ```dart
  import 'package:flutter_bloc/flutter_bloc.dart';

  class CounterCubit extends Cubit<int> {
    CounterCubit() : super(0);

    void increment() => emit(state + 1);
  }
  ```

---

#### 3. **syncfusion_flutter_gauges**
- کاربرد: ایجاد گوج‌ها (نمودارهای اندازه‌گیری).
- مثال استفاده:
  ```dart
  import 'package:syncfusion_flutter_gauges/gauges.dart';

  SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[...]),
    ],
  );
  ```

---

#### 4. **convex_bottom_bar**
- کاربرد: بار مسیریابی دارای طراحی مقعر.
- مثال استفاده:
  ```dart
  import 'package:convex_bottom_bar/convex_bottom_bar.dart';

  ConvexAppBar(
    items: [
      TabItem(icon: Icons.home, title: 'Home'),
      TabItem(icon: Icons.map, title: 'Map'),
    ],
  );
  ```

---

#### 5. **flutter_svg**
- کاربرد: برای نمایش فایل‌های SVG.
- مثال استفاده:
  ```dart
  import 'package:flutter_svg/flutter_svg.dart';

  SvgPicture.asset('assets/icon.svg');
  ```

---

#### 6. **google_fonts**
- کاربرد: استفاده از فونت‌های Google در Flutter.
- مثال استفاده:
  ```dart
  import 'package:google_fonts/google_fonts.dart';

  Text(
    'Hello, Flutter!',
    style: GoogleFonts.roboto(fontSize: 24),
  );
  ```

---

#### 7. **fl_chart**
- کاربرد: برای ساخت نمودارهای کاربردی (مثل خطی یا دایره‌ای).
- مثال استفاده:
  ```dart
  import 'package:fl_chart/fl_chart.dart';

  LineChart(
    LineChartData(
      lineBarsData: [...],
    ),
  );
  ```

---

#### 8. **http**
- کاربرد: برای درخواست HTTP به API‌ها.
- مثال استفاده:
  ```dart
  import 'package:http/http.dart' as http;

  final response = await http.get(Uri.parse('https://example.com'));
  ```

---

#### 9. **shared_preferences**
- کاربرد: ذخیره داده‌ها در حافظه محلی به صورت کلید و مقدار.
- مثال استفاده:
  ```dart
  import 'package:shared_preferences/shared_preferences.dart';

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('key', 'value');
  ```

---

#### 10. **accordion**
- کاربرد: ساخت لیست‌های آکاردئونی.
- مثال استفاده:
  ```dart
  import 'package:accordion/accordion.dart';

  Accordion(
    children: [
      AccordionSection(header: Text('Header'), content: Text('Content')),
    ],
  );
  ```

---

#### 11. **popover**
- کاربرد: نمایش پنجره‌های پاپ‌آپ.
- مثال استفاده:
  ```dart
  import 'package:popover/popover.dart';

  Popover(
    child: Text('Click me'),
    content: Text('Popover content'),
  );
  ```

---

#### 12. **camera**
- کاربرد: دسترسی به دوربین دستگاه.
- مثال استفاده:
  ```dart
  import 'package:camera/camera.dart';

  final cameras = await availableCameras();
  ```

---

#### 13. **permission_handler**
- کاربرد: مدیریت دسترسی‌ها.
- مثال استفاده:
  ```dart
  import 'package:permission_handler/permission_handler.dart';

  final status = await Permission.camera.request();
  ```

---

#### 14. **path_provider**
- کاربرد: دسترسی به مسیرهای فایل سیستم.
- مثال استفاده:
  ```dart
  import 'package:path_provider/path_provider.dart';

  final directory = await getApplicationDocumentsDirectory();
  ```

---

#### 15. **dio**
- کاربرد: درخواست‌های HTTP با قابلیت‌های پیشرفته.
- مثال استفاده:
  ```dart
  import 'package:dio/dio.dart';

  final dio = Dio();
  final response = await dio.get('https://example.com');
  ```

---

#### 16. **shimmer**
- کاربرد: نمایش افکت شایمر برای لودینگ.
- مثال استفاده:
  ```dart
  import 'package:shimmer/shimmer.dart';

  Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: Text('Loading'),
  );
  ```

---

#### 17. **camera_web**
- کاربرد: استفاده از دوربین در وب.

---

#### 18. **percent_indicator**
- کاربرد: نمایش نوارهای درصدی.
- مثال استفاده:
  ```dart
  import 'package:percent_indicator/percent_indicator.dart';

  CircularPercentIndicator(
    radius: 50.0,
    lineWidth: 5.0,
    percent: 0.7,
    center: Text('70%'),
  );
  ```

---

#### 19. **google_sign_in**
- کاربرد: احراز هویت با Google.
- مثال استفاده:
  ```dart
  import 'package:google_sign_in/google_sign_in.dart';

  final googleSignIn = GoogleSignIn();
  final account = await googleSignIn.signIn();
  ```

---

#### 20. **file_picker**
- کاربرد: انتخاب فایل از دستگاه.
- مثال استفاده:
  ```dart
  import 'package:file_picker/file_picker.dart';

  final result = await FilePicker.platform.pickFiles();
  ```

---

#### 21. **universal_html**
- کاربرد: کار با HTML در Flutter.

---

#### 22. **url_launcher**
- کاربرد: باز کردن URL‌ها در مرورگر یا اپلیکیشن.
- مثال استفاده:
  ```dart
  import 'package:url_launcher/url_launcher.dart';

  if (await canLaunch('https://example.com')) {
    await launch('https://example.com');
  }
  ```

---

#### 23. **visibility_detector**
- کاربرد: تشخیص وضعیت دیدن ویجت.
- مثال استفاده:
  ```dart
  import 'package:visibility_detector/visibility_detector.dart';

  VisibilityDetector(
    key: Key('widget-key'),
    onVisibilityChanged: (info) {
      print(info.visibleFraction);
    },
    child: Container(),
  );
  ```

---

#### 24. **focus_detector_v2**
- کاربرد: تشخیص وضعیت فوکوس ویجت.

---

#### 25. **introduction_screen**
- کاربرد: ساخت اسلایدهای معرفی اولیه.
- مثال استفاده:
  ```dart
  import 'package:introduction_screen/introduction_screen.dart';

  IntroductionScreen(
    pages: [PageViewModel(title: 'Welcome', body: 'Hello World!')],
  );
  ```

---

#### 26. **flutter_spinkit**
- کاربرد: نمایش انیمیشن‌های لودینگ.
- مثال استفاده:
  ```dart
  import 'package:flutter_spinkit/flutter_spinkit.dart';

  SpinKitWave(color: Colors.blue);
  ```

---

#### 27. **screenshot**
- کاربرد: گرفتن اسکرین‌شات از ویجت‌ها.
- مثال استفاده:
  ```dart
  import 'package:screenshot/screenshot.dart';

  final controller = ScreenshotController();
  final image = await controller.capture();
  ```

---

#### 28. **intl**
- کاربرد: مدیریت فرمت‌های تاریخ، زمان و اعداد.
- مثال استفاده:
  ```dart
  import 'package:intl/intl.dart';

  final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  ```

---

#### 29. **colorful_safe_area**
- کاربرد: مدیریت SafeArea با رنگ‌بندی.

---

