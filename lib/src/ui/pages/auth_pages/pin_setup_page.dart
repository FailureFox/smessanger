import 'package:flutter/material.dart';

class PinSetupPage extends StatelessWidget {
  const PinSetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Setup pin code', style: Theme.of(context).textTheme.headline1),
          const Text('Create a four digits code'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).backgroundColor,
              )
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 3 / 2.6,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '1',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '2',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '3',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '4',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '5',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '6',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '7',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '8',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '9',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '.',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Text(
                      '0',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.backspace_outlined)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
