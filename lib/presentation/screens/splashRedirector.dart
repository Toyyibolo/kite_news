import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kite_news/presentation/screens/home.dart';
import 'package:kite_news/presentation/screens/home_page.dart';
import 'package:rive/rive.dart';

import '../providers/enabledCategories.dart';
import '../providers/preloadProvider.dart';


class SplashRedirector extends ConsumerStatefulWidget {
  const SplashRedirector({super.key});

  @override
  ConsumerState<SplashRedirector> createState() => _SplashRedirectorState();
 }

class _SplashRedirectorState extends ConsumerState<SplashRedirector> {
  @override
  void initState() {
    super.initState();

     preloading();
  }

  preloading(){
    try {
      Future.microtask(() async {
        final preload = await ref.read(preloadProvider.future);
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Home()),
        );

      });
    } on Exception catch (e) {
      // TODO
      return SnackBar(content: Text(e.toString()) );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: RiveAnimation.asset(
                'assets/rive/kitebykagi.riv',
                fit: BoxFit.cover,
                artboard: 'kagiskite',
                stateMachines: ['kiteStateMachine'],
                alignment: Alignment.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kite',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lufga',
                  )),
                Text('News Elevated',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lufga',
                  ),

                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
