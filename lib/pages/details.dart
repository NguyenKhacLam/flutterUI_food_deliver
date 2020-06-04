import 'package:flutter/material.dart';
import 'package:fooddeliver/core/const.dart';
import 'package:fooddeliver/core/flutter_icons.dart';
import 'package:fooddeliver/models/food.dart';

class DetailPage extends StatefulWidget {
  DetailPage({this.data});
  final FoodModel data;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greenColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _customNav(),
            Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/bg.png"),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "image${widget.data.imgPath}",
                      child: Image(
                        image: AssetImage("assets/${widget.data.imgPath}"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.data.name}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\&${widget.data.price.toInt()}",
                          style: TextStyle(
                            fontSize: 32,
                            color: AppColor.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        _buildCounter()
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildInfor(
                            "Weight", "${widget.data.weight.toInt()} gm"),
                        _buildInfor(
                            "Calories", "${widget.data.calorie.toInt()} cal"),
                        _buildInfor(
                            "Protein", "${widget.data.protein.toInt()} gm"),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Items",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("${widget.data.item}"),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {},
                            color: AppColor.greenColor,
                            padding: EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Text(
                              "Add to cart",
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfor(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          val,
          style: TextStyle(
            fontSize: 16,
            color: AppColor.redColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _customNav() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Icon(
                FlutterIcons.left,
                size: 12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Icon(
              FlutterIcons.shop,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.greenColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.black,
              size: 16,
            ),
            onPressed: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "1",
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 16,
            ),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
