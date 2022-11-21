import 'package:flutter/material.dart';

commentsWidget(comment, context) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 231, 231),
            borderRadius: BorderRadius.circular(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Text(
                    "A",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Text(
                  "userName",
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(comment.toString()),
            ),
          ],
        ),
      ),
    ],
  );
}

replyCard(context, reply) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.only(left: 20, right: 50, top: 20),
    width: MediaQuery.of(context).size.width / 2,
    decoration: BoxDecoration(
        color: const Color.fromARGB(113, 158, 158, 158),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: const Text(
            "A",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(reply.toString()),
        ),
      ],
    ),
  );
}
