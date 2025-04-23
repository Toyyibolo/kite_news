import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kite_news/core/extensions/captalization_extension.dart';
import 'package:kite_news/core/extensions/spacing_extensions.dart';
import 'package:kite_news/presentation/providers/enabledCategories.dart';
import 'package:kite_news/presentation/screens/category_settings.dart';
import 'package:kite_news/presentation/screens/settings_page.dart';
import 'package:kite_news/presentation/widgets/async_dependent_value_widget.dart';
import 'package:kite_news/presentation/widgets/summaryText.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';

class KiteHome extends ConsumerStatefulWidget {
  const KiteHome({super.key});

  @override
  ConsumerState<KiteHome> createState() => _KiteHomeState();
}


class _KiteHomeState extends ConsumerState<KiteHome> {
  bool _isCollapsed = false;
  int _currentIndex = 0;
   late String timeOfDay;
   DateTime now = DateTime.now();
   late String formattedDate;
   late String today;

  @override
   void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final enabledCategories = ref.read(enabledCategoriesProvider);
      ref.read(SelectedCategoriesProvider.notifier).select(enabledCategories[0]);
    });
    today = DateFormat('EEEE').format(now);
    formattedDate = DateFormat('dd MMM yyyy').format(now);
   super.initState();
    timeOfDay = getTimeOfDayPeriod(now);

   }


 


  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final enabledCategories = ref.watch(enabledCategoriesProvider);
    final selectedCategory = ref.watch(SelectedCategoriesProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceDim,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/images/kite.svg', width: 50, height: 50),
            10.wb,
            TranslatableText(
              'Kite News',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: 'Lufga',
              ),
            ),
            12.wb,
            IconButton(
              icon: Icon(Icons.settings, color: colorScheme.onSurface, size: 25),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              if (!_isCollapsed) SliverToBoxAdapter(child: 10.hb),
              if (!_isCollapsed) SliverToBoxAdapter(child: _buildSummarySection(context)),
              Builder(
                builder: (context) {
                  return SliverPersistentHeader(
                    pinned: true,
                    delegate: _CategoryHeaderDelegate(
                      onToggle: _toggleCollapse,
                      isCollapsed: _isCollapsed,
                      screenWidth: screenWidth,
                      enabledCategories: enabledCategories,
                      ref: ref,
                      selectedCategory: selectedCategory,
                    ),
                  );
                }
              ),
              SliverToBoxAdapter(child: 15.hb),
              SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, ref, child) {
                    //final selectedCategory = ref.watch(SelectedCategoriesProvider);
                    return KiteNewsListWidget(
                      error: Center(child: TranslatableText('Error loading news', style: textTheme.bodyMedium)),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
  String getTimeOfDayPeriod(DateTime time) {
    final hour = time.hour;
    if (hour >= 5 && hour < 12) {
      return 'morning';
    } else if (hour >= 12 && hour < 17) {
      return 'afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'evening';
    } else {
      return 'night';
    }
  }



  Widget _buildSummarySection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedCategory = ref.watch(SelectedCategoriesProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TranslatableText('Summary', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          TranslatableText(formattedDate, style: textTheme.bodySmall?.copyWith(color: colorScheme.onBackground.withOpacity(0.7))),
          const SizedBox(height: 20),
          TranslatableText(
            "Good $timeOfDay, Kitey! It's $today, $formattedDate. Here is the summary for today's news...",
            style: textTheme.bodyMedium,
          ),
          Summarytext(ref: ref, category:  selectedCategory),
        ],
      ),
    );
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onToggle;
  final bool isCollapsed;
  final double screenWidth;
  final List<String> enabledCategories;
  final String selectedCategory;
  final WidgetRef ref;

  _CategoryHeaderDelegate({
    required this.onToggle,
    required this.isCollapsed,
    required this.screenWidth,
    required this.enabledCategories,
    required this.selectedCategory,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and arrow toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TranslatableText('Explore Categories', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(
                  isCollapsed ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  color: colorScheme.onBackground,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Chips always visible
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: enabledCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                
                final chipCategory = enabledCategories[index].toLowerCase();
                final isSelected = selectedCategory == chipCategory;

                return GestureDetector(
                  onTap: (){
                    ref.read(SelectedCategoriesProvider.notifier).select(enabledCategories[index].toLowerCase());

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.grey : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.onSurface.withOpacity(0.5)),

                    ),
                    child: Center(
                      child: TranslatableText(
                        enabledCategories[index].capitalize(),
                        style: TextStyle(color: colorScheme.onSurface),
                      )
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 130;
  @override
  double get minExtent => 130;

  @override
  bool shouldRebuild(covariant _CategoryHeaderDelegate oldDelegate) => true;
}
