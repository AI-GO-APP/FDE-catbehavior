class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/login';
  
  // User App Shell
  static const String home = '/home';
  static const String booking = '/booking';
  static const String courses = '/courses';
  static const String profile = '/profile';
  static const String myBookings = '/my-bookings'; // 拉為主級 Tab
  
  // User App sub pages
  static const String sitterSearch = '/sitter-search';
  static const String consultantList = 'consultants';
  static const String consultantDetail = '/consultant/:id';
  static const String sitterDetail = '/sitter/:id';
  static const String bookingCalendar = 'calendar';
  static const String bookingForm = '/booking-form';
  
  // Admin Shell
  static const String adminDashboard = '/admin/dashboard';
  static const String adminBookings = '/admin/bookings';
  static const String adminConsultants = '/admin/consultants';
  static const String adminCourses = '/admin/courses';
  
  // Admin sub pages
  static const String adminBookingDetail = '/admin/booking/:id';
  static const String adminCourseEdit = '/admin/course/:id';
  static const String adminConsultantEdit = '/admin/consultant/:id';
}
