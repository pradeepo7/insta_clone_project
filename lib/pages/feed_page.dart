import 'package:flutter/material.dart';
import 'package:settlin/models/image_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:settlin/utilities/circle_container_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedPage extends StatelessWidget {
  List<dynamic> _list = [];
  static const String profile_url =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(snapshot.error.toString()))
            ],
          );
        } else if (snapshot.hasData) {
          List data = snapshot.data as List;
          return RefreshIndicator(
            onRefresh: fetchApi,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        ImageModel _model = _list[i];
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Colors.pink,
                                    Colors.orange,
                                    Colors.yellow,
                                    Colors.redAccent,
                                  ],
                                ),
                              ),
                              height: 143,
                              width: 100,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(i != 0
                                            ? _model.downloadUrl
                                            : profile_url),
                                        fit: BoxFit.cover),
                                    color: Colors.grey,
                                  ),
                                  height: 140,
                                  width: 96,
                                  child: Stack(
                                    alignment: AlignmentDirectional.topCenter,
                                    fit: StackFit.expand,
                                    children: [
                                      SizedBox(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Center(
                                            child: (i != 0)
                                                ? Text(
                                              _model.author,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                                : circle_container_icon(
                                                Icon(
                                                  CupertinoIcons.plus,
                                                  color: Colors.black,
                                                  size: 40,
                                                ),
                                                background_color:
                                                Colors.white)),
                                      ),
                                      if (i == 1)
                                        Positioned(
                                          bottom: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.pink,
                                                  Colors.pinkAccent,
                                                ],
                                              ),
                                            ),
                                            height: 20,
                                            width: 50,
                                            child: Center(
                                              child: Text(
                                                'Live',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            backgroundImage:
                            CachedNetworkImageProvider(profile_url),
                            radius: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'What do you think?',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24.0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        circle_container_icon(Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.black87,
                        ))
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider()),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) {
                      ImageModel _model = _list[i];
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipOval(
                                          child: CircleAvatar(
                                            radius: 23,
                                            backgroundColor: _model.id % 2 == 0
                                                ? Colors.grey
                                                : Colors.green,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                                backgroundImage:
                                                CachedNetworkImageProvider(
                                                    _model.downloadUrl),
                                                radius: 20),
                                          )),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(_model.author,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          Row(
                                            children: [
                                              Text("30 mins"),
                                              const SizedBox(width: 10),
                                              Icon(Icons.people)
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      LikeButton(
                                        circleSize: 5,
                                        circleColor: CircleColor(
                                            start: Color(0xffff5252),
                                            end: Color(0xfff50000)),
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: Color(0xFFF65151),
                                            dotSecondaryColor:
                                            Color(0xFFEA3D2D),
                                            dotThirdColor: Color(0xFFDE2525),
                                            dotLastColor: Color(0xFFFF1300)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(24.0)),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                _model.downloadUrl),
                                            fit: BoxFit.cover),
                                        color: Colors.grey),
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: CircleAvatar(
                                            backgroundImage:
                                            CachedNetworkImageProvider(
                                                profile_url),
                                            radius: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                              height: 30,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintStyle:
                                                  TextStyle(fontSize: 10),
                                                  hintText: "Say Something",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        circle_container_icon(
                                            Icon(
                                              Icons.share,
                                              color: Colors.black87,
                                              size: 18,
                                            ),
                                            height: 26.0,
                                            width: 26.0)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider()
                            ],
                          ));
                    },
                    childCount: 20,
                  ),
                ),
              ],
            ),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }

  Future<dynamic> fetchApi() async {
    try {
      http.Response result =
      await http.get(Uri.parse('https://picsum.photos/v2/list'));
      print(result.body);
      List data = json.decode(result.body);
      data.forEach((element) {
        _list.add(ImageModel.fromJson(element));
      });
      return _list;
    } catch (e) {
      throw e;
    }
  }
}