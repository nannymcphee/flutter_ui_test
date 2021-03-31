import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';
import 'package:nft/utils/app_extension.dart';

import 'package:nft/utils/app_style.dart';

class WCourseItem extends StatelessWidget with DynamicSize {
  const WCourseItem({Key key, this.color, this.title, this.image, this.teacher, this.rating, this.onTap}) : super(key: key);

  final Color color;
  final String title;
  final String image;
  final String teacher;
  final String rating;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    initDynamicSize(context);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.W, right: 10.W, bottom: 10.H),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.H),
            color: color,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4.0,
                offset: const Offset(0, 4),
              )
            ]
        ),
        child: Container(
          padding: EdgeInsets.all(15.H),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 65.W,
                height: 40.H,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.H),
                    color: Colors.white
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.W, right: 5.W),
                      child: const Icon(
                        Icons.star,
                        color: Colors.deepOrange,
                        size: 16,
                      ),
                    ),
                    Text(
                      rating,
                      style: normalTextStyle(12.W, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.H),
              Text(
                title,
                style: semiBoldTextStyle(20.W, color: Colors.white),
              ),
              SizedBox(height: 15.H),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: image,
                    child: Container(
                      width: 70.W,
                      height: 70.H,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.W),
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  SizedBox(width: 10.W),
                  Container(
                    // padding: EdgeInsets.only(top: 60.H, right: 17.W, bottom: 30.H),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Teacher',
                          style: normalTextStyle(14.W, color: Colors.white.withOpacity(0.8)),
                        ),
                        SizedBox(height: 8.H),
                        Text(
                          teacher,
                          style: boldTextStyle(16.W, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
