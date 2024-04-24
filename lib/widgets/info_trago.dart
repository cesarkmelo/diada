import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TragoMuestras extends StatelessWidget {
  const TragoMuestras({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String assetBeer = 'images/beer-drink-jar-outline.svg';
    final String assetWine = 'images/wine-glass-full-of-drink.svg';
    final String assetShot = 'images/glass-with-dark-drink.svg';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          'Se define como un trago a:',
        ),
        Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('Un vaso de cerveza (330ml)')),
                SvgPicture.asset(
                  assetBeer,
                  color: kPrimaryColor,
                  semanticsLabel: 'Un vaso',
                ),
              ],
            ),
            Divider(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Una copa de vino (150ml)'),
                ),
                SvgPicture.asset(
                  assetWine,
                  color: kPrimaryColor,
                  semanticsLabel: 'Una copa',
                  height: 40.0,
                ),
              ],
            ),
            Divider(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      'Una copa de (45ml) de licor destilado (aguardiente, ron, vodka, whisky) u otros licores.'),
                ),
                SvgPicture.asset(
                  assetShot,
                  color: kPrimaryColor,
                  semanticsLabel: 'Un shot',
                  height: 35.0,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
