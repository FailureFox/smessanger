import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/resources/data/countries_data.dart';
import 'package:smessanger/src/ui/screens/auth_screen.dart';
import 'package:smessanger/src/ui/styles/colors.dart';

class NumberInputPage extends StatelessWidget {
  const NumberInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthAppbar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_Texts.phoneTitle,
                      style: Theme.of(context).textTheme.headline1),
                  const SizedBox(height: 5),
                  const Text(_Texts.phoneSubtitle),
                  const SizedBox(height: 20),
                  const NumberInputField(),
                  const SizedBox(height: 20),
                  const Text(_Texts.phonePrivacyText),
                  const Spacer(),
                  const NumberNextButton()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NumberInputField extends StatelessWidget {
  const NumberInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
          validator: (value) {
            if (value != null) {
              if (value.length < 5) {
                return 'Не существует такого номера';
              }
            }
          },
          maxLines: null,
          minLines: null,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [MaskTextInputFormatter(mask: '##-###-##-####')],
          keyboardType: TextInputType.phone,
          onChanged: (value) => context
              .read<AuthBloc>()
              .add(AuthNumberChangeEvent(number: value)),
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(const Duration(milliseconds: 100),
                    () => dialCodeSelectBottomSheet(context));
              },
              child:
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.only(left: 15, right: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 15,
                          child: Image.asset(state.selectedCountry.flag)),
                      const SizedBox(width: 10),
                      Text(
                        state.selectedCountry.dialCode,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                );
              }),
            ),
            hintText: 'Phone number',
          )),
    );
  }
}

dialCodeSelectBottomSheet(BuildContext mycontext) {
  return showModalBottomSheet(
      context: mycontext,
      builder: (context) => DraggableScrollableSheet(
            maxChildSize: 1,
            initialChildSize: 1,
            minChildSize: 0.5,
            snap: true,
            expand: false,
            builder: (context, scrollcontroller) => Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: MediaQuery.of(mycontext).size.width / 9,
                      child: TextField(
                        onChanged: (value) => mycontext
                            .read<AuthBloc>()
                            .add(AuthCountrySearchInputEvent(search: value)),
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.dbackgroundML
                                    : AppColors.lbackgroundMD,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search'),
                      ),
                    )),
                Expanded(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: mycontext.read<AuthBloc>(),
                    builder: (context, state) {
                      if (state.countrySearch == '') {
                        return ListView.builder(
                          controller: scrollcontroller,
                          itemCount: Countries.countryList.length,
                          itemBuilder: (context, index) {
                            return CountryItemsWidget(
                                myContext: mycontext,
                                country: Countries.countryList[index]);
                          },
                        );
                      } else {
                        return ListView(
                          children: (Countries.countryList
                                  .where((element) =>
                                      (element['en_short_name'] +
                                              element['dial_code'] as String)
                                          .toLowerCase()
                                          .contains(state.countrySearch
                                              .toLowerCase()))
                                  .toList())
                              .map((e) => CountryItemsWidget(
                                  country: e, myContext: mycontext))
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ));
}

class NumberNextButton extends StatelessWidget {
  const NumberNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      width: double.infinity,
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return ElevatedButton(
          child: const Text('Next'),
          onPressed:
              state.phoneNumber == '' || state.status is AuthLoadingStatus
                  ? null
                  : () => onPressed(context),
        );
      }),
    );
  }

  onPressed(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    context.read<AuthBloc>().add((AuthNumberVerifyEvent(context: context)));
  }
}

class _Texts {
  //phone input
  static const String phoneSubtitle = "We'll send you a sign-in code";
  static const String phoneTitle = "What's your phone?";
  static const String phonePrivacyText =
      "By entering your number. you're agreeing to our Terms Of Sevice and Privacy Policy";
}

class CountryItemsWidget extends StatelessWidget {
  const CountryItemsWidget(
      {Key? key, required this.country, required this.myContext})
      : super(key: key);
  final Map<String, dynamic> country;
  final BuildContext myContext;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        myContext
            .read<AuthBloc>()
            .add(AuthCountrySelectEvent(CountriesModel.fromMap(country)));
      },
      leading: SizedBox(
          height: 25,
          child: Image.asset('assets/flags/' +
              (country['alpha_2_code'] as String).toLowerCase() +
              '.png')),
      title: Text(country['en_short_name']),
      subtitle: Text(country['dial_code']),
    );
  }
}
