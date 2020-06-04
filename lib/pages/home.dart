import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fooddeliver/core/const.dart';
import 'package:fooddeliver/core/flutter_icons.dart';
import 'package:fooddeliver/models/food.dart';
import 'dart:math' as math;

import 'package:fooddeliver/pages/details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foodList = FoodModel.list;
  PageController pageController = PageController(viewportFraction: .8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: _buildRightSection(),
              ),
              Container(
                color: AppColor.greenColor,
                height: MediaQuery.of(context).size.height,
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: ExactAssetImage("assets/profile.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(FlutterIcons.menu),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 25,
                child: Transform.rotate(
                  angle: -math.pi / 2,
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      buildMenu("Vegetables"),
                      buildMenu("Chicken"),
                      buildMenu("Beef"),
                      buildMenu("Vietnam"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenu(String menu) {
    return Container(
      width: 150,
      padding: EdgeInsets.only(top: 12),
      child: Center(
        child: Text(
          menu,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildRightSection() {
    return Column(
      children: <Widget>[
        _customAppBar(),
        Expanded(
          child: ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 350,
//                    What is fuck is this? 👇
                        child: PageView.builder(
                          controller: pageController,
                          physics: BouncingScrollPhysics(),
                          itemCount: foodList.length,
                          itemBuilder: (context, index) {
//                        What is fuck is this? 👇
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DetailPage(
                                      data: foodList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Stack(
                                  children: <Widget>[
                                    buildFoodItem(index),
                                    Hero(
                                      tag: "image${foodList[index].imgPath}",
                                      child: Align(
                                        child: Transform.rotate(
                                          child: Image(
                                            image: AssetImage(
                                                "assets/${foodList[index].imgPath}"),
                                            width: 180,
                                          ),
                                          angle: math.pi / 3,
                                        ),
                                        alignment: Alignment.topRight,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.redColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ),
                                        child: Text(
                                          "\$${foodList[index].price.toInt()}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Popular",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              buildPopularList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFoodItem(int index) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 50, bottom: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(),
            ),
            Row(
              children: <Widget>[
                RatingBar(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  unratedColor: Colors.black12,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "(120 reviews)",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Text(
              "${foodList[index].name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPopularList() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 30, top: 20),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  data: foodList[index],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColor.greenLightColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Row(
              children: <Widget>[
                Center(
                  child: Image(
                    image: AssetImage("assets/${foodList[index].imgPath}"),
                    width: 100,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      foodList[index].name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\$${foodList[index].price.toInt()}",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColor.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text("${foodList[index].weight.toInt()} gm Weight",
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _customAppBar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
                text: 'Hello,\n',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Shailee Weedly',
                    style: TextStyle(
                      color: AppColor.greenColor,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ]),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.greenLightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
                Icon(FlutterIcons.search),
              ]),
            ),
          ),
          SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Icon(FlutterIcons.shop),
            ),
          )
        ],
      ),
    );
  }
}
