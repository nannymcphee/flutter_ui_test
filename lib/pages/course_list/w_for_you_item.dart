import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';
import 'package:nft/utils/app_extension.dart';

import '../../utils/app_style.dart';

class WForYouItem extends StatelessWidget with DynamicSize {
  const WForYouItem({Key key, this.color, this.title, this.image, this.teacher, this.rating, this.onTap}) : super(key: key);

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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.H),
            color: color,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.0,
                offset: const Offset(0, 4),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.W),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: image,
                    child: Container(
                      width: 40.W,
                      height: 40.H,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.W),
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  SizedBox(width: 8.W),
                  Flexible(
                    child: Text(
                      teacher,
                      style: normalTextStyle(14.W, color: Colors.black),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.W),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.W, top: 10.W, bottom: 20.H),
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
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.W, right: 15.W, bottom: 10.W),
                        child: Text(
                          title,
                          style: boldTextStyle(16.W, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
