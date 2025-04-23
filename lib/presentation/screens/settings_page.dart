import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kite_news/presentation/providers/themeProvider.dart';
import 'package:kite_news/presentation/screens/category_settings.dart';
import 'package:kite_news/presentation/widgets/translatorText.dart';

import '../providers/language_provider.dart';


class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late Box settingsBox;
  final List<String> languages = [
    'English',
    'Português',
    'Italiano',
    'Français',
    'Español',
    'Deutsch',
    'Nederlands',
    '中文',
    '日本語',
    'हिन्दी',
  ];

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box('settingsBox');
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final savedDarkMode = settingsBox.get('darkMode', defaultValue: false);
    final savedLanguage = settingsBox.get('language', defaultValue: 'English');
    ref.read(themeDataProvider.notifier).state = savedDarkMode;
    ref.read(selectedLanguageProvider.notifier).setLanguage(savedLanguage); //= savedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDarkMode = ref.watch(themeDataProvider);
    final selectedLanguage = ref.watch(selectedLanguageProvider);
    final selectLangName = ref.watch(selectectedLanguageName);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: TranslatableText("Settings", style: theme.textTheme.titleLarge),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslatableText(
              "Select Language",
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff2a2a2a) : Colors.grey[200],
                border: Border.all(color: theme.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectLangName,
                  isExpanded: true,
                  dropdownColor: isDark ? const Color(0xff2a2a2a) : Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.colorScheme.primary),
                  style: theme.textTheme.bodyMedium,
                  items: languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TranslatableText(language),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedLanguageProvider.notifier).setLanguage(value);
                      ref.read(selectedLanguageProvider.notifier).setLanguage(selectLangName);
                      settingsBox.put('language', value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TranslatableText(
                  "Dark Mode",
                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                Switch(
                  value: isDarkMode,
                  activeColor: theme.colorScheme.primary,
                  onChanged: (value) {
                    ref.read(themeDataProvider.notifier).state = value;
                    settingsBox.put('darkMode', value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CategorySelectorPage()));
              },
              child: SizedBox(
                width: double.infinity,
                child: TranslatableText(
                  "Category Settings",
                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: TranslatableText(
                "About Kite",
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: TranslatableText(
                "Kite News is your daily dose of global perspectives.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              leading: Icon(Icons.info_outline, color: theme.colorScheme.primary),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Kite News",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Kite News Inc.",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
