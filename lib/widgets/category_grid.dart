import 'package:beehive/providers/home_provider.dart';
import 'package:beehive/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<HomeProvider>(context, listen: false);
    final extractCategories = categoriesData.mainCategories;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        childAspectRatio: 16 / 15,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          for (int i = 0; i < extractCategories!.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      color: whtColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage('${extractCategories[i].image}'),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${extractCategories[i].title}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cario',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
