import 'package:album_search/pages/detail/controller/album_detail_view_model.dart';
import 'package:album_search/pages/home/controller/search_view_model.dart';
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
        ChangeNotifierProvider.value(value: AlbumDetailViewModel()),
      ],
      child: MaterialApp(
        title: 'Search App',
        debugShowCheckedModeBanner: false,
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
            headline3: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            headline4: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
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
