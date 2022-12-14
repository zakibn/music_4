import 'package:flutter/material.dart';

Widget customListTile({required String title, required String  singer, required String cover, onTab}) {
 
 
  return InkWell(
    onTap: onTab,
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Container(
          height: 80.0, 
          width: 80.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(image: NetworkImage(cover))),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              singer,
              style: const  TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ],
        )
      ]),
    ),
  );
}
