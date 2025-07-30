import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/text_style.dart';
import '../res/colors.dart';

class NotificationWidget extends StatefulWidget {
  final int notificationCount;
  final List<NotificationItem> notifications;
  final VoidCallback? onNotificationTap;

  const NotificationWidget({
    Key? key,
    required this.notificationCount,
    required this.notifications , 
    this.onNotificationTap,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () => _toggleNotificationDropdown(),
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/notification.svg",
              width: 25,
              height: 25,
              color: AppColors.mainSecandaryColor,
            ),
            if (widget.notificationCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    widget.notificationCount > 99 ? '99+' : widget.notificationCount.toString(),
                    style: AppTextStyles.hintWhite.copyWith(fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _toggleNotificationDropdown() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      // _showNotificationDropdown();
    }
  }

  void _showNotificationDropdown() {
    _overlayEntry = OverlayEntry(
      builder: (context) => NotificationDropdown(
        layerLink: _layerLink,
        notifications: widget.notifications,
        onNotificationTap: widget.onNotificationTap,
        onClose: _removeOverlay,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class NotificationDropdown extends StatelessWidget {
  final LayerLink layerLink;
  final List<NotificationItem> notifications;
  final VoidCallback? onNotificationTap;
  final VoidCallback onClose;

  const NotificationDropdown({
    Key? key,
    required this.layerLink,
    required this.notifications,
    this.onNotificationTap,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dropdownWidth = 320.0;
    final rightMargin = 20.0; // Margin from right edge
    
    return Stack(
      children: [
        // Tap outside to close
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        // Notification dropdown - positioned on the right side
        Positioned(
          right: rightMargin,
          top: 60, // Position below the header
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: dropdownWidth,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.SilverGray,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.SilverGray,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notifications",
                          style: AppTextStyles.title1,
                        ),
                        Row(
                          children: [
                            Text(
                              "${notifications.length}",
                              style: AppTextStyles.hintMedium,
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: onClose,
                              child: const Icon(
                                Icons.close,
                                color: AppColors.purpleDark,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Notifications List
                  Flexible(
                    child: notifications.isEmpty
                        ? _buildEmptyState()
                        : _buildNotificationsList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/notification.svg",
            width: 48,
            height: 48,
            colorFilter: const ColorFilter.mode(
              AppColors.textLite,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "No notifications yet",
            style: AppTextStyles.title1,
          ),
          const SizedBox(height: 4),
          Text(
            "You'll see important updates here",
            style: AppTextStyles.hint,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItemWidget(
          notification: notification,
          onTap: () {
            if (onNotificationTap != null) {
              onNotificationTap!();
            }
            onClose();
          },
        );
      },
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback? onTap;

  const NotificationItemWidget({
    Key? key,
    required this.notification,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : AppColors.bgScreen,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.isRead ? AppColors.SilverGray : AppColors.gray100,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and unread indicator
          Row(
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.gray,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          // Message
          Text(
            notification.message,
            style: AppTextStyles.hint,
          ),
          const SizedBox(height: 8),
          // Time and Proceed button row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatTime(notification.timestamp),
                style: AppTextStyles.hintSmale,
              ),
              // Proceed button with text and arrow (no background/border)
              GestureDetector(
                onTap: onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Proceed",
                      style: AppTextStyles.hintPurple.copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.mainSecandaryColor,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class NotificationItem {
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final Map<String, dynamic>? data;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.data,
  });
}

enum NotificationType {
  success,
  warning,
  error,
  info,
}

// Sample notification data for testing
class NotificationData {
  static List<NotificationItem> getSampleNotifications() {
    return <NotificationItem>[
      NotificationItem(
        title: "Welcome!",
        message: "Welcome to your health dashboard. Start tracking your biomarkers.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        type: NotificationType.info,
        isRead: false,
      ),
      NotificationItem(
        title: "Daily Check-in",
        message: "Time for your daily health check-in. Log your water and exercise.",
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: NotificationType.success,
        isRead: false,
      ),
    ];
  }
} 