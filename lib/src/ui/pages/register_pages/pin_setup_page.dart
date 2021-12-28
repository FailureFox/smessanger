import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';

class PinSetupPage extends StatefulWidget {
  const PinSetupPage({Key? key}) : super(key: key);

  @override
  State<PinSetupPage> createState() => _PinSetupPageState();
}

class _PinSetupPageState extends State<PinSetupPage> {
  pinChange(String value) {
    if (isFirst) {
      if (pin.length < 4) {
        setState(() {
          pin = pin + value;
          pin.length == 4 ? isFirst = false : null;
        });
      }
    } else {
      if (secondPin.length < 4) {
        setState(() {
          secondPin = secondPin + value;
        });
      }
      if (secondPin.length == 4) {
        if (pin == secondPin) {
          context
              .read<RegistrationBloc>()
              .add(RegPinCodeChangeEvent(pinCode: pin));
          context.read<RegistrationBloc>().nextPage();
        } else {
          pin = '';
          secondPin = '';
          isFirst = true;
          setState(() {});
        }
      } 
    }
  }

  pinBackSpace() {
    if (isFirst) {
      if (pin.isNotEmpty) {
        final pinArray = pin.split('');
        pinArray.removeLast();
        pin = pinArray.join();
        setState(() {});
      }
    } else {
      if (secondPin.isNotEmpty) {
        final pinArray = secondPin.split('');
        pinArray.removeLast();
        secondPin = pinArray.join();
        setState(() {});
      }
    }
  }

  String pin = '';
  String secondPin = '';
  bool isFirst = true;
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
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 30,
                    backgroundColor:
                        (isFirst ? pin.length : secondPin.length) > index
                            ? Theme.of(context).hintColor
                            : Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.3,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: (MediaQuery.of(context).size.width / 5) /
                  (MediaQuery.of(context).size.height / 15),
              children: [
                ...List.generate(
                    9,
                    (index) => SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width / 5,
                          child: IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => pinChange('${index + 1}'),
                              icon: Text(
                                '${index + 1}',
                                style: Theme.of(context).textTheme.headline4,
                              )),
                        )),
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
