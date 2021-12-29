import 'package:flutter/material.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/models/roles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolesSelectPage extends StatelessWidget {
  const RolesSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.read<RegistrationBloc>().pervousePage(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).hintColor,
            )),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What roles have you    played',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: const [
                RolesWidget(text: 'Engineer', role: Roles.engineer),
                RolesWidget(text: 'Founder', role: Roles.founder),
                SizedBox(width: 30),
                RolesWidget(text: 'Investor', role: Roles.investor),
                RolesWidget(
                    text: 'Product manager', role: Roles.productManager),
                RolesWidget(
                  text: 'Marketing and sales',
                  role: Roles.marketingAndSales,
                ),
                RolesWidget(text: 'Recourter', role: Roles.recruiter),
                RolesWidget(text: 'Designer', role: Roles.designer),
                RolesWidget(text: 'Another', role: Roles.another),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                onPressed: () => context.read<RegistrationBloc>().nextPage(),
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RolesWidget extends StatefulWidget {
  const RolesWidget({Key? key, required this.text, required this.role})
      : super(key: key);
  final String text;
  final Roles role;

  @override
  State<RolesWidget> createState() => _RolesWidgetState();
}

class _RolesWidgetState extends State<RolesWidget> {
  bool active = false;
  ontap() {
    if (!active) {
      context
          .read<RegistrationBloc>()
          .add(RegRoleSelectEvent(role: widget.role));
    } else {
      context
          .read<RegistrationBloc>()
          .add(RegRoleDeleteEvent(role: widget.role));
    }
    active = !active;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: !active
              ? Theme.of(context).backgroundColor
              : Theme.of(context).colorScheme.primary,
        ),
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 17,
                color: !active ? null : Theme.of(context).backgroundColor),
          ),
        ),
      ),
    );
  }
}
