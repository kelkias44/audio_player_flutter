import 'package:audio_player/presentation/screens/albums.dart';
import 'package:audio_player/presentation/screens/explore.dart';
import 'package:audio_player/presentation/screens/favorites.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int choosed = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffE6DBDD),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: const Color(0xffFE3562),
              child: TabBar(
                onTap: (value) {
                  setState(() {
                    choosed = value;
                  });
                },
                tabs: [
                  Tab(
                    child: tabBarElemen('Explore', 0),
                  ),
                  Tab(
                    child: tabBarElemen('Albums', 1),
                  ),
                  Tab(
                    child: tabBarElemen('Favorites', 2),
                  )
                ],
                indicatorColor: Colors.transparent,
              ),
            ),
            const Expanded(
                child:
                    TabBarView(children: [Explore(), Albums(), Favorites()])),
          ],
        ),
      ),
    );
  }

  Widget tabBarElemen(String title, int code) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: choosed == code ? Colors.white : Colors.transparent),
      child: Text(
        title,
        style: TextStyle(
            color: choosed == code ? Colors.black : Colors.white, fontSize: 11),
      ),
    );
  }
}
