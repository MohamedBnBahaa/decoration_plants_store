import 'package:flutter/material.dart';

class ShowDetailsText extends StatefulWidget {
  const ShowDetailsText({Key? key}) : super(key: key);

  @override
  State<ShowDetailsText> createState() => _ShowDetailsTextState();
}

class _ShowDetailsTextState extends State<ShowDetailsText> {
  bool isShowMore = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0, vertical: 16.0,),
          child: const Text(
            "Details :",
            style: TextStyle(fontSize: 24.0,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0,),
          child: Text(
            "A flowerpot, planter or plant pot, is a container in which flowers and other plants are cultivated and displayed. Historically, and still to a significant extent today, they are made from plain terracotta with no ceramic glaze, with a round shape, tapering inwards. Flowerpots are now often also made from plastic, metal, wood, stone, or sometimes biodegradable material. An example of biodegradable pots are ones made of heavy brown paper, cardboard, or peat moss in which young plants for transplanting are grown.",
            style: const TextStyle(fontSize: 18.0,),
            maxLines: isShowMore ? 4 : null,
            overflow: TextOverflow.fade,
          ),
        ),
        TextButton(
          onPressed: (){
            setState(() {
              isShowMore = !isShowMore;
            });
          },
          child: Text(
            isShowMore ? "Show more" : "Show less",
            style: const TextStyle(fontSize: 18.0,),
          ),
        )
      ],
    );
  }
}
