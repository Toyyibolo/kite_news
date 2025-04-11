import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/presentation/screens/home_page.dart';

void main() => runApp( ProviderScope(child: KiteApp()));

class KiteApp extends StatelessWidget {
  const KiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Builder(
            builder: (context) {
              return Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => KiteHomePage()));
                  },
                  child: Text(
                    'Kite News',
                    ),
                )
              );
            }
          ),
        )
      ),
    );
  }
}