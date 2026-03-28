import 'package:go_router/go_router.dart';
import 'package:quicktools/features/image_editing/ImageFormatter/ui/image_formatter_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/image_converter/ui/image_converter_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    GoRoute(
      path: '/imageCompressor',
      builder: (context, state) => const ImageConverterScreen(),
    ),

    GoRoute(
      path: '/imageFormatter',
      builder: (context, state) => const ImageFormatterScreen(),
    ),
  ],
);
