import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girman_search/widgets/user_details_card.dart';

import '../data/models/user_model.dart';
import '../utility/theme.dart';

class UserContactAndFetchDetails extends StatelessWidget {
  final User user;
  const UserContactAndFetchDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        //contact and available on phone
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //contact
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: ColorTheme.black01,
                  size: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    user.contactNumber,
                    style: const TextStyle(
                        color: ColorTheme.black01,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),

            //available on phone
            const Text('Available on phone',
              style: TextStyle(
                color: ColorTheme.textGrey02,
                fontSize: 10,
              ),
            ),
          ],
        ),

        //fetch details
        GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                barrierDismissible: true,  // Allow dismissing by tapping outside
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),),// Optional, control inset space from screen edges
                    child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.7,
                        maxHeight: Get.height * 0.45,
                    ),
                      decoration: BoxDecoration(
                        color: ColorTheme.primaryLogo,
                        borderRadius: BorderRadius.circular(10),),
                      padding: const EdgeInsets.all(16),  // Optional, padding inside the container
                      child: UserDetailsCard(user: user),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: ColorTheme.black02
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Fetch Details',
                    style: TextStyle(
                      color: ColorTheme.primaryLogo,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
        ),
      ],
    );
  }
}
