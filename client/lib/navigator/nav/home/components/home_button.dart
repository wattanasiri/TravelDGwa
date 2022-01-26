import 'package:flutter/material.dart';
import 'package:se_app2/constants.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key key,
    this.icon,
    this.text,
    this.route,
  }) : super(key: key);

  final String icon;
  final String text;
  final route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: Container(
          width: 90,
          height: 80,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.all(Radius.circular(14),),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(icon,
                      width: 32.0, height: 32.0),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Text(text,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
      ),
    );
  }
}
