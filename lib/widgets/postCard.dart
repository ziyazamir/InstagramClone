import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class postCard extends StatelessWidget {
  final snap;
  const postCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(snap['profImage']),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    alignment: Alignment.topLeft,
                  ),
                  child: Text(
                    snap['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )),
              Container(
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                    title: const Text("Choose Actions"),
                                    children: [
                                      SimpleDialogOption(
                                        onPressed: () {},
                                        child: const Text(
                                            // onPressed: () {},
                                            ('Delete')),
                                      ),
                                      const Divider(),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.more_vert))),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    // padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_sharp,
                      color: Colors.red,
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmarks_outlined)),
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('${snap['likes'].length} Likes')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: snap['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(text: " ${snap['description']}")
                    ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: InkWell(
                      child: Container(
                        // padding: ,
                        child: const Text(
                          "View all 200 comments",
                          style: TextStyle(fontSize: 16, color: secondaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: ,
                    child: Text(
                      DateFormat.yMMMMd()
                          .format(snap['datePublished'].toDate()),
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
