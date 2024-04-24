import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';

class MainMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const MainMenuItem(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.1, 0.5), //(x,y)
                blurRadius: 0.5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  title,
                  style: kLoginTextStyle,
                ),
              ),
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 15,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
