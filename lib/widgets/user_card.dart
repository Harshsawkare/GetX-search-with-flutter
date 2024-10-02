
import 'package:flutter/material.dart';
import 'package:girman_search/data/models/user_model.dart';
import 'package:girman_search/utility/theme.dart';
import 'package:girman_search/widgets/user_card_bottom_row.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.84),
          side: const BorderSide(
            color: ColorTheme.border03,
            width: 0.86,
          )),
      color: ColorTheme.primaryLogo,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              width: 67.45,
              height: 67.45,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorTheme.border04),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/image.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
            ),

            //name
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(
                  color: ColorTheme.textBlack01,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),

            //address
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: ColorTheme.locationIcon,
                  size: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    user.city,
                    style: const TextStyle(
                      color: ColorTheme.locationIcon,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Divider(
                thickness: 1,
                color: ColorTheme.border04,
              ),
            ),

            //contact and fetch details
            UserContactAndFetchDetails(user: user)

          ],
        ),
      ),
    );
  }
}
