import 'package:copilet/res/colors.dart';
import 'package:copilet/widgets/Tasks.dart';
import 'package:copilet/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import '../../components/text_style.dart';
import '../../widgets/PercentIndicator.dart';
import '../../widgets/friendsThumbnail.dart';
import '../../widgets/normal-Gauges.dart';
import '../../widgets/smallGauge.dart';
import '../../widgets/totalScoreGauge.dart';
import 'package:dio/dio.dart';
import '../../constants/endPoints.dart';
import '../../utility/token/getTokenLocaly.dart';

class ProgressScreen extends StatefulWidget {
  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _planProgressOpacity;
  late Animation<double> _calendarOpacity;
  Timer? _weeklyTasksTimer;
  bool _isPlanProgressVisible = true; // Tracks which item is visible
  int selectedDate = DateTime.now().day;

  // --- Weekly Tasks State ---
  List<Map<String, dynamic>> weeklyTasks = [];
  bool isWeeklyTasksLoading = false;
  String? weeklyTasksError;

  // --- Fetch Weekly Tasks Function ---
  Future<void> fetchWeeklyTasks() async {
    setState(() {
      isWeeklyTasksLoading = true;
      weeklyTasksError = null;
    });
    try {
      var token = await getTokenLocally();
      Dio dio = Dio();
      dio.options.headers['Authorization'] = "bearer $token";
      final response = await dio.post(Endpoints.getWeeklyTasks);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        setState(() {
          weeklyTasks = jsonData.cast<Map<String, dynamic>>();
          isWeeklyTasksLoading = false;
        });
      } else {
        setState(() {
          weeklyTasksError = 'Failed to load weekly tasks';
          isWeeklyTasksLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        weeklyTasksError = e.toString();
        isWeeklyTasksLoading = false;
      });
    }
  }

  /// Returns the weeklyTasks object for the currently selected day
  Map<String, dynamic>? getSelectedDayTasksObject(List<DateTime> dates) {
    final selected = dates.firstWhere(
      (d) => d.day == selectedDate && d.month == d.month && d.year == d.year,
      orElse: () => DateTime(1900),
    );
    if (selected.year == 1900) return null;
    String selectedDateString = _formatDate(selected);
    final found = weeklyTasks.firstWhere(
      (obj) => obj['date'] == selectedDateString,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return found;
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// Returns true if the selected date is today, false otherwise
  bool _isSelectedDateToday(List<DateTime> dates) {
    final selected = dates.firstWhere(
      (d) => d.day == selectedDate && d.month == d.month && d.year == d.year,
      orElse: () => DateTime(1900),
    );
    if (selected.year == 1900) return false;
    
    final today = DateTime.now();
    return selected.year == today.year && 
           selected.month == today.month && 
           selected.day == today.day;
  }

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
    );

    // Define Animations using CurvedAnimation
    _planProgressOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _calendarOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scrollController.addListener(_onScroll);
    fetchWeeklyTasks();
    _weeklyTasksTimer = Timer.periodic(Duration(seconds: 20), (timer) {
      fetchWeeklyTasks();
    });
  }

  @override
  void dispose() {
  _scrollController.dispose();
  _animationController.dispose();
  _weeklyTasksTimer?.cancel();
  super.dispose();
  }

  void _onScroll() {
    double offset = _scrollController.offset;

    if (offset > 50 && _isPlanProgressVisible) {
      // Trigger fade out of PlanProgressSection and fade in HorizontalCalendar
      setState(() {
        _isPlanProgressVisible = false;
      });
      _animationController.forward();
    } else if (offset <= 50 && !_isPlanProgressVisible) {
      // Trigger fade in of PlanProgressSection and fade out HorizontalCalendar
      setState(() {
        _isPlanProgressVisible = true;
      });
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dates = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index - 2)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Progress", style: AppTextStyles.title1),
                    NotificationWidget(
                      notificationCount: 2,
                      notifications: [
                        NotificationItem(
                          title: "New Tasks, New You!",
                          message: "Your latest health action plan is ready! Check out your new tasks in the Overview section and take the next step toward a longer, healthier life.",
                          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
                          type: NotificationType.info,
                          isRead: false,
                        ),
                        NotificationItem(
                          title: "Your Progress Awaits!",
                          message: "Ready to level up your health? Complete your Health Questionnaire to help us build a more personalized and effective wellness plan just for you.",
                          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
                          type: NotificationType.info,
                          isRead: false,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // PlanProgressSection (فقط وقتی فعال است)
                if (_isPlanProgressVisible)
                  Stack(
                    children: [
                      FadeTransition(
                        opacity: _planProgressOpacity,
                        child: PlanProgressSection(
                          weeklyTasks: weeklyTasks,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.purpleDark.withOpacity(0.35), size: 32),
                          onPressed: () {
                            setState(() {
                              _isPlanProgressVisible = false;
                            });
                            _animationController.forward();
                          },
                        ),
                      ),
                    ],
                  ),
                // اگر کلندر فعال است، فضای خالی بگذار (ارتفاع کلندر)
                if (!_isPlanProgressVisible)
                  SizedBox(height: 110),
                const SizedBox(height: 16),
                // بقیه محتوای اسکرول‌شونده
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tasks(
                          title: "Daily Tasks",
                          tasksList: getSelectedDayTasksObject(dates)?['tasks']?.cast<Map<String, dynamic>>(),
                          readOnly: !_isSelectedDateToday(dates),
                        ),
                        // ... سایر بخش‌ها ...
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // کلندر را فیکس بالا قرار بده و فقط وقتی _isPlanProgressVisible=false باشد نمایش بده
          if (!_isPlanProgressVisible)
            FadeTransition(
              opacity: _calendarOpacity,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    HorizontalCalendar(
                      dates: dates,
                      selectedDate: selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                        final selectedDayObject = getSelectedDayTasksObject(dates);
                        print('Selected day object:');
                        print(selectedDayObject);
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_up, color: AppColors.purpleDark.withOpacity(0.35), size: 32),
                        onPressed: () {
                          setState(() {
                            _isPlanProgressVisible = true;
                          });
                          _animationController.reverse();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Plan Progress Section
class PlanProgressSection extends StatelessWidget {
  final List<Map<String, dynamic>> weeklyTasks;

  PlanProgressSection({required this.weeklyTasks});

  // ساختن map از روز به مقدار progress
  Map<String, double> getProgressByDay() {
    Map<String, List<double>> tempMap = {
      'Sun': [],
      'Mon': [],
      'Tue': [],
      'Wed': [],
      'Thu': [],
      'Fri': [],
      'Sat': [],
    };
    for (var item in weeklyTasks) {
      String? day = item['day'];
      double progress = 0;
      if (item['progress'] != null) {
        if (item['progress'] is int) {
          progress = (item['progress'] as int).toDouble();
        } else if (item['progress'] is double) {
          progress = item['progress'];
        }
        // نرمالایز کردن مقدار progress
        if (progress > 1) {
          progress = progress / 100.0;
        }
      }
      if (day != null && tempMap.containsKey(day)) {
        tempMap[day]!.add(progress);
      }
    }
    // محاسبه میانگین برای هر روز
    Map<String, double> progressMap = {};
    tempMap.forEach((day, progresses) {
      if (progresses.isNotEmpty) {
        progressMap[day] = progresses.reduce((a, b) => a + b) / progresses.length;
      } else {
        progressMap[day] = 0;
      }
    });
    return progressMap;
  }

  @override
  Widget build(BuildContext context) {
    final progressByDay = getProgressByDay();
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: AppColors.mainBg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // rgba(201, 235, 237, 1)
              color: AppColors.mainShadow.withOpacity(.25),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(4, 0), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   width: 20,
              //   height: 2,
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 2, color: AppColors.greenLite),
              //       color: AppColors.yellowBega),
              // ),
              // const SizedBox(
              //   width: 5,
              // ),
              // Text(
              //   'Main Plan',
              //   style: AppTextStyles.hint,
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              // Row(
              //   children: [
              //     Container(
              //       width: 20,
              //       height: 2,
              //       decoration: BoxDecoration(
              //           border:
              //               Border.all(width: 2, color: AppColors.yellowBega),
              //           color: AppColors.yellowBega),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       'Alternative Plan',
              //       style: AppTextStyles.hint,
              //     ),
              //   ],
              // ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BarChartWidget(
                  day: 'Sun',
                  mainPlan: progressByDay['Sun'] ?? 0,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
              BarChartWidget(
                  day: 'Mon',
                  mainPlan: progressByDay['Mon'] ?? 0,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
              BarChartWidget(
                  day: 'Tue',
                  mainPlan: progressByDay['Tue'] ?? 0,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
              BarChartWidget(
                  day: 'Wed',
                  mainPlan: progressByDay['Wed'] ?? 2,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
              BarChartWidget(
                  day: 'Thu',
                  mainPlan: progressByDay['Thu'] ?? 0,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
              BarChartWidget(
                  day: 'Fri',
                  mainPlan: progressByDay['Fri'] ?? 0,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
              BarChartWidget(
                  day: 'Sat',
                  mainPlan: progressByDay['Sat'] ?? 0,
                  color: AppColors.greenLite,
                  alternativePlan: 0),
            ],
          ),
        ],
      ),
    );
  }
}

// Bar Chart Widget for weekly progress
class BarChartWidget extends StatelessWidget {
  final String day;
  final double mainPlan;
  final double alternativePlan;
  final Color color;

  const BarChartWidget(
      {required this.day,
      required this.mainPlan,
      required this.alternativePlan,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 150,
              width: 22,
              decoration: BoxDecoration(
                color: AppColors.bgChartProgress,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 150 * mainPlan,
                width: 22,
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          
          ],
        ),
        SizedBox(height: 8),
        Text(day, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Daily Goal Completion Section
class GoalCompletionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.purpleLite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
              child: SmallGauge(
            colorGauge: AppColors.pinkBorder,
            value: 25,
          )),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Your daily goals almost done!',
                      style: AppTextStyles.titleMedium),
                  Icon(Icons.local_fire_department, color: Colors.orange),
                ],
              ),
              SizedBox(height: 8),
              Text('1 of 4 completed', style: AppTextStyles.hint),
            ],
          ),
        ],
      ),
    );
  }
}

// Challenges Section
class ChallengesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Challenges",
          style: AppTextStyles.title2,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  // rgba(201, 235, 237, 1)
                  color: AppColors.mainShadow.withOpacity(.25),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(4, 0), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.blue.withOpacity(.5)),
                      SizedBox(width: 8),
                      Text('Best Runners!', style: AppTextStyles.hintMedium),
                    ],
                  ),
                  OverlappingCirclesScreen()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('5 days 13 hours left', style: AppTextStyles.hint),
                    Text("2 friends joined", style: AppTextStyles.hint),
                    // OverlappingCirclesScreen()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                value: 500 / 2000,
                backgroundColor: AppColors.gray,
                color: AppColors.yellowLite,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Tasks Section
class TasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Drink the water', style: TextStyle(fontSize: 16)),
              IconButton(
                icon: Icon(Icons.swap_horiz),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: 500 / 2000,
            backgroundColor: Colors.grey[300],
            color: Colors.green,
          ),
          SizedBox(height: 8),
          Text('500/2000 ML'),
        ],
      ),
    );
  }
}

class WaterTaskWidget extends StatelessWidget {
  String title;
  String iconSrc;
  double value;
  String des;
  WaterTaskWidget(
      {required this.title, required this.value,required this.des, required this.iconSrc});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainShadow.withOpacity(.25),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(4, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Circular Progress and Water Icon
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      value: value, // Progress based on 500/2000 ML
                      backgroundColor: Colors.blue[100],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    // const Icon(
                    //   Icons.water_drop,
                    //   color: Colors.blue,
                    //   size: 16,
                    // ),
                    ClipRRect(
                        borderRadius:
                            BorderRadius.circular(1000), // Image border

                        child: Image.asset(
                          fit: BoxFit.cover,
                          iconSrc,
                          width: 10,
                          height: 10,
                        )),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // Task Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.hintMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    des,
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ],
          ),
          // Swap and Add (+) Buttons
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    // isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SwapBottomSheet();
                    },
                  );
                },
                child: Column(
                  children: [
                    SvgPicture.asset("assets/repeat-circle.svg"),
                    Text(
                      'Swap',
                      style: AppTextStyles.hint,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    // isScrollControlled: true,
                    builder: (BuildContext context) {
                      return AddBtnBottomSheet();
                    },
                  );
                },
                child: SvgPicture.asset(
                  "assets/AddButton.svg",
                  width: 35,
                  height: 35,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// Swap Bottom Sheet Content
class SwapBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50,
              ),
              Text('Swap for Water', style: AppTextStyles.title2xl),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.purpleDark,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          // Search bar
          const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search to swap...',
                border: InputBorder.none),
          ),
          SizedBox(height: 90),
          // Placeholder for items to swap
        ],
      ),
    );
  }
}

class AddBtnBottomSheet extends StatefulWidget {
  const AddBtnBottomSheet({super.key});

  @override
  State<AddBtnBottomSheet> createState() => _AddBtnBottomSheetState();
}

class _AddBtnBottomSheetState extends State<AddBtnBottomSheet> {
  int glasses = 0;
  final int goal = 8;

  void incrementGlasses() {
    setState(() {
      if (glasses < goal) {
        glasses++;
      }
    });
  }

  void decrementGlasses() {
    setState(() {
      if (glasses > 0) {
        glasses--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(children: [
        Positioned(
          top: -10,
          right: -10,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColors.purpleDark,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Water for Today',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$glasses Glasses',
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: incrementGlasses,
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: AppColors.hintLite,
                      ),
                    ),
                    GestureDetector(
                      onTap: decrementGlasses,
                      child: Icon(Icons.remove,
                          size: 18, color: AppColors.hintLite),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'of $goal',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Add save logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Changes saved', style: AppTextStyles.hintWhite),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purpleDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Save Changes', style: AppTextStyles.hintWhite),
            ),
          ],
        ),
      ]),
    );
  }
}

class HorizontalCalendar extends StatefulWidget {
  final List<DateTime> dates;
  final int selectedDate;
  final Function(int) onDateSelected;

  const HorizontalCalendar({
    Key? key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),

      height: 110, // Height of the calendar
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.dates.length,
        itemBuilder: (context, index) {
          final date = widget.dates[index];
          final isSelected = date.day == widget.selectedDate;

          return GestureDetector(
            onTap: () => widget.onDateSelected(date.day),
            child: Container(
              width: 64,
              height: 95,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? AppColors.purpleDark : Colors.white, width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColorWithOpacity,
                    blurRadius: 10,
                    offset: Offset(4, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${date.day}",
                      style: !isSelected
                          ? AppTextStyles.title3xlLiteGray
                          : AppTextStyles.title3xlgreen),
                  const SizedBox(height: 4),
                  Text(_getWeekdayName(date.weekday),
                      style: !isSelected
                          ? AppTextStyles.title2Gray
                          : AppTextStyles.title2Primary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }
}
