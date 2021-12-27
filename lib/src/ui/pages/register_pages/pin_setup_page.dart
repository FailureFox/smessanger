import 'package:flutter/material.dart';

class PinSetupPage extends StatefulWidget {
  const PinSetupPage({Key? key}) : super(key: key);

  @override
  State<PinSetupPage> createState() => _PinSetupPageState();
}

class _PinSetupPageState extends State<PinSetupPage> {
  pinChange(String value) {
    if (pin.length < 4) {
      setState(() {
        pin = pin + value;
      });
    }
  }

  pinBackSpace() {
    if (pin.isNotEmpty) {
      final pinArray = pin.split('');
      pinArray.removeLast();
      pin = pinArray.join();
      setState(() {});
    }
  }

  String pin = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Setup pin code', style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 10),
          const Text('Create a four digits code'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => CircleAvatar(
                radius: MediaQuery.of(context).size.width / 30,
                backgroundColor: pin.length > index
                    ? Theme.of(context).hintColor
                    : Theme.of(context).backgroundColor,
              ),
            ),
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
                ...List.generate(
                    9,
                    (index) => IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () => pinChange('${index + 1}'),
                        icon: Text(
                          '${index + 1}',
                          style: Theme.of(context).textTheme.headline4,
                        ))),
                const SizedBox(),
                IconButton(
                    onPressed: () => pinChange('0'),
                    icon: Text(
                      '0',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                IconButton(
                    onPressed: pinBackSpace,
                    icon: const Icon(Icons.backspace_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
