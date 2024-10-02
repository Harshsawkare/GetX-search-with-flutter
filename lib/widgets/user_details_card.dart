
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:girman_search/utility/theme.dart';

import '../data/models/user_model.dart';

class UserDetailsCard extends StatelessWidget {
  final User user;
  const UserDetailsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Employee details and close
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            //Employee details
            const Text('Employee Details',
              style: TextStyle(
                  color: ColorTheme.textBlack01,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),

            //close
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.close,
              color: ColorTheme.black01,
              size: 26,),
            )

          ],
        ),

        //description
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text('Here are the details of following employee.',
            maxLines: 2,
            style: TextStyle(
                color: ColorTheme.textGrey01,
                fontSize: 14,
            ),
          ),
        ),

        //name
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text('Name: ${user.firstName} ${user.lastName}',
            style: const TextStyle(
              color: ColorTheme.textBlack02,
              fontSize: 14,
            ),
          ),
        ),

        //location
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text('Location: ${user.city}',
            style: const TextStyle(
              color: ColorTheme.textBlack02,
              fontSize: 14,
            ),
          ),
        ),

        //contact
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text('Contact Number: ${user.contactNumber}',
            style: const TextStyle(
              color: ColorTheme.textBlack02,
              fontSize: 14,
            ),
          ),
        ),

        //profile Image
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text('Profile Image',
            style: TextStyle(
              color: ColorTheme.textBlack02,
              fontSize: 14,
            ),
          ),
        ),

        Image.asset('assets/image.jpeg',
        width: 190,
        height: 190,
        fit: BoxFit.cover,)

      ],
    );
  }
}
