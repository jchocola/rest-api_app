import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ShadDialog(
      title: Text('Your feedback'),
      description: Text('We would like your feedback to improve our website.'),
      actions: [
        ShadButton.secondary(child: Text('Send'),)
      ],
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShadSeparator.horizontal(),
            Text('What is your opinion of this page?'),
            AnimatedRatingStars(
              initialRating: 3.5,
              minRating: 0.0,
              maxRating: 5.0,
              filledColor: Colors.amber,
              emptyColor: Colors.grey,
              filledIcon: Icons.star,
              halfFilledIcon: Icons.star_half,
              emptyIcon: Icons.star_border,
              onChanged: (double rating) {
                // Handle the rating change here
                print('Rating: $rating');
              },
              displayRatingValue: true,
              interactiveTooltips: true,
              customFilledIcon: Icons.star,
              customHalfFilledIcon: Icons.star_half,
              customEmptyIcon: Icons.star_border,
              starSize: 30.0,
              animationDuration: Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              readOnly: false,
            ),

            ShadSeparator.horizontal(),

            Text('Please select your feedback category below.'),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShadBadge(child: Text('Suggestion'),),
                ShadBadge.secondary(child: Text('Bug'),),
                 ShadBadge.secondary(child: Text('Compliment'),), 
              ],
            ),

            ShadSeparator.horizontal(),

            Text('Please leave your feedback below:'),
            
            ShadTextarea(minHeight: size.height * 0.2),
            SizedBox(height: AppConstant.appPadding,),
          ],
        ),
      ),
    );
  }
}
