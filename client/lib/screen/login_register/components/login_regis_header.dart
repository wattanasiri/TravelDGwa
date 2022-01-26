import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';

class LoginRegisHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: paddingValue,
            right: paddingValue,
            bottom: 10 + paddingValue,
            top: 50 + paddingValue,
          ),
          margin: EdgeInsets.only(bottom: paddingValue * 2.5),
          height: 216,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70),
              ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(2, 6), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'TravelDGwa',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),

              const Divider(
                  height: 5,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.white
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'เที่ยวง่ายไม่มีหลงกับเรา ทราเวลดีกว่า',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),

            ],
          ),

        ),
      ],
    );
  }
}

