import 'package:flutter/material.dart';

class PhotoUploadPage extends StatelessWidget {
  const PhotoUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload a photo', style: Theme.of(context).textTheme.headline1),
          Center(
            child: CircleAvatar(
              backgroundColor: Theme.of(context).backgroundColor,
              radius: MediaQuery.of(context).size.width / 7,
              child: IconButton(
                  color: Theme.of(context).iconTheme.color,
                  splashRadius: 0.1,
                  iconSize: MediaQuery.of(context).size.width / 9,
                  onPressed: () {},
                  icon: const Icon(Icons.add_a_photo_rounded)),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width / 8,
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Next')))
        ],
      ),
    );
  }
}
