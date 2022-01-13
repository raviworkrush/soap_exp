import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soapexp/bloc/fetch_continents_cubit.dart';
import 'package:bottom_nav/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soap Exp',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        // fontFamily: GoogleFonts.lato().fontFamily,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
            fontFamily: GoogleFonts.lato().fontFamily,
          )
      ),
      home: const MyHomePage(title: 'Soap Exp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xff008E95) ,
        title: Center(child: Text(widget.title)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocProvider(
                  create: (context) => FetchContinentsCubit()..fetchContinents(),
                  child: BlocConsumer<FetchContinentsCubit, FetchContinentsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is FetchContinentsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FetchContinentsError) {
                        return Center(
                          child: Text(
                            'Failed to fetch continents: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is FetchContinentsLoaded) {
                        return CarouselSlider(
                            items: state.continents
                                .map((continent) => Card(
                              color: const Color(0xff008E95),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ListTile(
                                        title: Text(
                                          'Continent : $continent',
                                          style:
                                              Theme.of(context).textTheme.headline5,
                                        ),
                                        subtitle: Text(
                                          'Code : ${state.codes[state.continents.indexOf(continent)]}',
                                          style:
                                              Theme.of(context).textTheme.headline6,
                                        ),
                                      ),
                                    )))
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ));
                        // return ListView.builder(
                        //   itemCount: state.continents.length,
                        //   itemBuilder: (context, index) {
                        //     final continent = state.continents[index];
                        //     return ListTile(
                        //       title: Text(continent),
                        //     );
                        //   },
                        // );
                      }
                      return const Center(
                        child: Text(
                          'Failed to fetch continents',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    },
                  )),
            ),
          ),

          Expanded(
            flex: 2,
            child:
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage("images/pic1.jpeg"),
              ),
            ),
          )
            ,)
        ],
      ),
      bottomNavigationBar: BottomNav(
        index: currentTab,
        backgroundColor: Colors.white,
        showElevation: true,
        navBarHeight: 75.0,
        radius: 30.0,
        onTap: (i) {
          setState(() {
            currentTab = i;
          });
        },
        items: [
          BottomNavItem(
              icon: Icons.home, label: "Home", selectedColor: Colors.amber),
          BottomNavItem(
              icon: Icons.favorite,
              label: "Likes",
              selectedColor: Colors.pink),
          BottomNavItem(
              icon: Icons.search,
              label: "Search",
              selectedColor: Colors.blue),
          BottomNavItem(
              icon: Icons.person,
              label: "Profile",
              selectedColor: Colors.black),
        ],
      ),
    );
  }
}
