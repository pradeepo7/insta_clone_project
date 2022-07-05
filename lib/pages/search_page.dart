import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading:false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.search),
                    suffixIcon: IconButton(
                      icon: Icon(CupertinoIcons.clear),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: Center(
        child : Text("Search the thing you want  ")
      ),
    );
  }
}