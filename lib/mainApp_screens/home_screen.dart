import 'package:beehive/providers/home_provider.dart';
import 'package:beehive/widgets/category_grid.dart';
import 'package:beehive/widgets/colors.dart';
import 'package:beehive/widgets/search_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesData =
    Provider.of<HomeProvider>(context, listen: false);
    final extractCategories = categoriesData.mainCategories;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: whtColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.menu,color: blkColor,),
              const SizedBox(width: 10,),
              const Expanded(child: SearchButton()),
              const SizedBox(width: 10,),
              Icon(Icons.person,color: blkColor,),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              margin:const EdgeInsets.all(10),
              padding:const EdgeInsets.only(left: 10,right: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: themeColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset:const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Location",
                        style: TextStyle(
                          fontFamily: "Cario",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: whtColor,
                        ),
                      ),
                      Text("Pakistan",
                        style: TextStyle(
                          fontFamily: "Cario",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: whtColor,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_down_sharp,size: 30,color: whtColor,),
                ],
              ),
            ),
            Container(
              color: whtColor,
              margin:const EdgeInsets.all(10),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width / 2,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                itemCount: extractCategories?.length,
                itemBuilder: (context, index, realIndex) =>
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage(
                        placeholder: const AssetImage(
                            "assets/images/loading.gif"),
                        image: NetworkImage(
                          "${extractCategories?[index].image}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
            ),
         const  CategoryGrid()
          ],
        ),
      ),
    );
  }
}
