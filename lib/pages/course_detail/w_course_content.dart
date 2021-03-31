import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';
import 'package:nft/utils/app_extension.dart';

import '../../utils/app_style.dart';

class WCourseContent extends StatelessWidget with DynamicSize {
  const WCourseContent({Key key, this.color, this.icon, this.title, this.highlightedSubtitle, this.normalSubtitle}) : super(key: key);

  final Color color;
  final Icon icon;
  final String title;
  final String highlightedSubtitle;
  final String normalSubtitle;

  @override
  Widget build(BuildContext context) {
    initDynamicSize(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 60.W,
          height: 60.H,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle
          ),
          child: icon,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.W),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: boldTextStyle(16.W, color: Colors.black),
              ),
              SizedBox(height: 8.H),
              RichText(
                text: TextSpan(
                    style: normalTextStyle(14.H, color: Colors.black.withOpacity(0.5)),
                    children: <TextSpan>[
                      TextSpan(
                        text: highlightedSubtitle,
                        style: normalTextStyle(14.H, color: color),
                      ),
                      TextSpan(
                        text: normalSubtitle,
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
