class NotificationSettingSchema {
  static const String notifications = 'notification';
  static const String email = 'email';
  static const String sms = 'sms';
  static const String push = 'push';
  static const String interviewScheduled = 'interview_scheduled';
  static const String interviewCancelled = 'interview_cancelled';
  static const String invitationStatusChanged = 'invitation_status_changed';
  static const String offerStatusChanged = 'offer_status_changed';
  static const String completedShiftAwaitingApproval =
      'completed_shift_awaiting_approval';
  static const String lateShiftClockin = 'late_shift_clockin';
  static const String upcomingInterview = 'upcoming_interview';
  static const String unreadMessages = 'unread_message_notification';
}
