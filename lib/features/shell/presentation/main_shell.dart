import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_bottom_nav.dart';
import '../../community/presentation/pages/community_page.dart';
import '../../explore/presentation/pages/explore_page.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../profile/presentation/pages/profile_page.dart';

/// Tab aktif navigasi bawah. Dipakai bersama oleh shell dan halaman dalam
/// (Agenda, Notifikasi) agar tap pada nav bawah bisa kembali ke shell.
final ValueNotifier<int> mainTabIndex = ValueNotifier<int>(0);

/// Kerangka utama: isi tab + navigasi bawah.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  static const String routeName = '/home';

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    super.initState();
    mainTabIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: mainTabIndex,
      builder: (context, index, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: IndexedStack(
            index: index,
            children: const [
              HomePage(),
              ExplorePage(),
              CommunityPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: AppBottomNav(
            currentIndex: index,
            onTap: (i) => mainTabIndex.value = i,
          ),
        );
      },
    );
  }
}