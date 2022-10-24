import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(
            width: 10,
          ),
         const Text(
            "Search",
            style: TextStyle(
              fontFamily: "Cario",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}