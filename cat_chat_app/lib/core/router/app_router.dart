import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/main_shell.dart';
import '../widgets/mock_page.dart';
import '../../features/home/home_page.dart';
import '../../features/booking/booking_page.dart';
import '../../features/courses/courses_page.dart';
import '../../features/sitter/sitter_page.dart';
import '../../features/profile/profile_page.dart';
import '../widgets/admin_shell.dart';
import '../../features/admin/admin_dashboard_page.dart';
import '../../features/admin/admin_bookings_page.dart';
import '../../features/admin/admin_consultants_page.dart';
import '../../features/admin/admin_courses_page.dart';
import '../../features/admin/admin_booking_detail_page.dart';
import '../../features/admin/admin_course_edit_page.dart';
import '../../features/admin/admin_consultant_edit_page.dart';
import '../../features/booking/professional_detail_page.dart';
import '../../features/booking/booking_form_page.dart';
import '../../features/profile/my_bookings_page.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _adminShellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    // 啟動頁
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const MockPage(title: '啟動中...'),
    ),
    
    // Auth
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const MockPage(title: '登入 / 註冊'),
    ),
    
    // User App 帶 BottomNavigationBar 的介面
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.booking,
          builder: (context, state) => const BookingPage(),
        ),
        GoRoute(
          path: AppRoutes.myBookings,
          builder: (context, state) => const MyBookingsPage(),
        ),
        GoRoute(
          path: AppRoutes.courses,
          builder: (context, state) => const CoursesPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    
    // User App 獨立內頁 (不含 BottomNav)
    GoRoute(
      path: AppRoutes.sitterSearch,
      builder: (context, state) => const SitterPage(), // 沿用原本的 SitterPage 進行微調
    ),
    GoRoute(
      path: AppRoutes.consultantDetail,
      builder: (context, state) => ProfessionalDetailPage(
        id: state.pathParameters['id'] ?? '1',
        isSitter: false,
      ),
    ),
    GoRoute(
      path: AppRoutes.sitterDetail,
      builder: (context, state) => ProfessionalDetailPage(
        id: state.pathParameters['id'] ?? '1',
        isSitter: true,
      ),
    ),
    GoRoute(
      path: AppRoutes.bookingForm,
      builder: (context, state) => const BookingFormPage(),
    ),
    
    // Admin (Web 端佈局)
    ShellRoute(
      navigatorKey: _adminShellNavigatorKey,
      builder: (context, state, child) {
        return AdminShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.adminDashboard,
          builder: (context, state) => const AdminDashboardPage(),
        ),
        GoRoute(
          path: AppRoutes.adminBookings,
          builder: (context, state) => const AdminBookingsPage(),
        ),
        GoRoute(
          path: AppRoutes.adminConsultants,
          builder: (context, state) => const AdminConsultantsPage(),
        ),
        GoRoute(
          path: AppRoutes.adminCourses,
          builder: (context, state) => const AdminCoursesPage(),
        ),
        GoRoute(
          path: AppRoutes.adminBookingDetail,
          builder: (context, state) => AdminBookingDetailPage(id: state.pathParameters['id'] ?? '1000'),
        ),
        GoRoute(
          path: AppRoutes.adminCourseEdit,
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return AdminCourseEditPage(id: id == 'new' ? null : id);
          },
        ),
        GoRoute(
          path: AppRoutes.adminConsultantEdit,
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return AdminConsultantEditPage(id: id == 'new' ? null : id);
          },
        ),
      ],
    ),
  ],
);
