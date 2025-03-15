import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/helper.dart';
import '../../../injectors/main_injector.dart';
import '../../../main.dart';
import '../../data_sources/app_shared_prefs.dart';
import '../../domain/entities/language_enum.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  LanguageEnum selectedLanguage = Helper.getLang();

  @override
  void initState() {
    selectedLanguage = Helper.getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kToolbarHeight),

          // Language
          Text(
            /*S.of(context).language*/
            'English',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          // Arabic language
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Theme.of(context).iconTheme.color,
            ),
            child: RadioListTile(
              activeColor:
                  selectedLanguage != LanguageEnum.ar
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).cardColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                /*S.of(context).arabic*/
                'Arabic',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              value: LanguageEnum.values[0],
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                setState(() {
                  //App.setLocale(context, selectedLanguage);
                });
              },
            ),
          ),

          // English language
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Theme.of(context).iconTheme.color,
            ),
            child: RadioListTile(
              activeColor:
                  selectedLanguage != LanguageEnum.en
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).cardColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                /*S.of(context).english*/
                'English',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              value: LanguageEnum.values[1],
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                setState(() {
                  //App.setLocale(context, selectedLanguage);
                });
              },
            ),
          ),

          // Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helper.isDarkTheme()
                    ? /*S.of(context).dark_skin*/ 'Dark'
                    : /*S.of(context).light_skin*/ 'Light',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Switch(
                activeColor: Theme.of(context).cardColor,
                inactiveTrackColor: Colors.grey,
                value: Helper.isDarkTheme(),
                onChanged: (value) {
                  if (value) {
                    // Dark
                    MainInjector.instance<AppSharedPrefs>().setDarkTheme(true);
                  } else {
                    // Light
                    MainInjector.instance<AppSharedPrefs>().setDarkTheme(false);
                  }
                  Provider.of<AppNotifier>(
                    context,
                    listen: false,
                  ).updateThemeTitle(
                    MainInjector.instance<AppSharedPrefs>().getIsDarkTheme(),
                  );
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
