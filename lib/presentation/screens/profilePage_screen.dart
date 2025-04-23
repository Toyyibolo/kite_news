import 'package:flutter/material.dart';
import 'package:kite_news/presentation/screens/history_page.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TranslatableText(
          "Profile",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                const SizedBox(height: 16),
                TranslatableText(
                  "Toheeb Opadijo",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 6),
                TranslatableText(
                  "Kitey",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff2a2a2a) : Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  _buildProfileItem(
                    context: context,
                    icon: Icons.bookmark_border,
                    title: "Saved Articles",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const HistoryPage(),
                      ));
                    },
                  ),
                  Divider(color: theme.dividerColor.withOpacity(0.2)),
                  _buildProfileItem(
                    context: context,
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    trailing: Switch(
                      value: true,
                      onChanged: (val) {},
                      activeColor: theme.colorScheme.primary,
                    ),
                  ),
                  Divider(color: theme.dividerColor.withOpacity(0.2)),
                  _buildProfileItem(
                    context: context,
                    icon: Icons.language,
                    title: "Language",
                    subtitle: "English",
                    onTap: () {},
                  ),
                  Divider(color: theme.dividerColor.withOpacity(0.2)),
                  const SizedBox(height: 30),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: TranslatableText(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      subtitle: subtitle != null
          ? TranslatableText(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.6),
              ),
            )
          : null,
      trailing: trailing ??
          Icon(Icons.chevron_right,
              color: theme.colorScheme.onBackground.withOpacity(0.3)),
      onTap: onTap,
    );
  }
}
