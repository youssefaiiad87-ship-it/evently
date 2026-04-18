import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/provider/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../../core/theme/app_colors.dart';

class AppSetup extends StatelessWidget {
  const AppSetup({super.key});

  static const String routeName = "AppSetup";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<AppConfigProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .center,
                children: [
                  Image.asset(
                    "assets/images/${provider.isDark ? "logo_dark.png" : "logo_light.png"}",
                    width: width * 0.4,
                  ),
                ],
              ),
              Expanded(child: Image.asset("assets/images/${provider.isDark ? "app_setup_dark.png":"app_setup_light.png"}")),
              Text(
                localizations.appSetupTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                localizations.appSetupDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Text(
                   localizations.language,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                  _buildItemSelector(
                    Text(
                      localizations.english,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: provider.isEn
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    provider.isEn,
                    () {
                      provider.changeLocal("en");
                    },
                    context,
                  ),
                  SizedBox(width: 8),
                  _buildItemSelector(
                    Text(
                      localizations.arabic,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: !provider.isEn
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    !provider.isEn,
                    () {
                      provider.changeLocal("ar");
                    },
                    context,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    localizations.theme,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                  _buildItemSelector(
                    Icon(
                      Icons.light_mode,
                      color: !provider.isDark
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.primary,
                    ),
                    !provider.isDark,
                    () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    context,
                  ),
                  SizedBox(width: 8),
                  _buildItemSelector(
                    Icon(
                      Icons.dark_mode,
                      color: provider.isDark
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.primary,
                    ),
                    provider.isDark,
                    () {
                      provider.changeTheme(ThemeMode.dark);
                    },
                    context,
                  ),
                ],
              ),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                ),
                child: Text(localizations.letStart),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemSelector(
    Widget content,
    bool isSelected,
    VoidCallback onTap,
    BuildContext context,
  ) {
    var theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? theme.primary : theme.primary.withAlpha(20),
          border: Border.all(width: 1, color: theme.primary),
        ),
        child: content,
      ),
    );
  }
}
