import 'package:album_search/pages/home/controller/media_view_model.dart';
import 'package:album_search/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SearchViewModel()),
      ],
      child: MaterialApp(
        title: 'Search App',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryTextTheme: const TextTheme(
            headline1: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
