import 'package:flutter/material.dart';
import 'package:kite_news/presentation/screens/history_page.dart';
import 'package:kite_news/presentation/screens/home.dart';
import 'package:kite_news/presentation/screens/profilePage_screen.dart';
import 'package:kite_news/presentation/screens/settings_page.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const KiteHome();
      case 1:
        return const HistoryPage();
      case 2:
        return const ProfilePage(); 
      default:
        return const Scaffold(
          body: Center(child: TranslatableText("Page not found")),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: _getPage(_currentIndex),
         bottomNavigationBar: BottomAppBar(
          color: colorScheme.surfaceDim,
          elevation: 10,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem(
                  icon: Icons.home_rounded,
                  label: "Home",
                  selected: _currentIndex == 0,
                  onTap: () {
                    setState(() {});
                    _onTabSelected(0);
                  },
                ),

                _buildTabItem(
                  icon: Icons.bookmark_rounded,
                  label: "History",
                  selected: _currentIndex == 2,
                  onTap: () => _onTabSelected(1),
                ), 
                _buildTabItem(
                  icon: Icons.person_rounded,
                  label: "Profile",
                  selected: _currentIndex == 3,
                  onTap: () => _onTabSelected(2),
                ),
              ],
            ),
          ),
        ),
    );
    
  }
  Widget _buildTabItem({
  required IconData icon,
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: selected ? Color(0xff007aff) : Color(0xff9e9e9e), size: 18,),
        const SizedBox(height: 2),
        TranslatableText(
          label,
          style: TextStyle(
            fontSize: 10,
            color: selected ? Color(0xff007aff) : Color(0xff9e9e9e),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

}


