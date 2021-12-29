import 'package:flutter/material.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/ui/screens/home_screen.dart';
import 'package:smessanger/src/ui/styles/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController(initialPage: 0);
  int myPage = 0;
  nextPage() {
    if (myPage < 2) {
      controller.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      myPage++;
      setState(() {});
    } else {
      context.read<RegistrationBloc>().add(RegRegisterAccountEvent());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  pervousPage() {
    if (controller.page != 0) {
      controller.previousPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      myPage--;
      setState(() {});
    } else {
      context.read<RegistrationBloc>().pervousePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: pervousPage,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).hintColor,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: const [
                IntroPageItems(
                  title: _TextsAndImages.title1,
                  subtitle: _TextsAndImages.subtitle1,
                  image: _TextsAndImages.image1,
                ),
                IntroPageItems(
                  title: _TextsAndImages.title2,
                  subtitle: _TextsAndImages.subtitle2,
                  image: _TextsAndImages.image2,
                ),
                IntroPageItems(
                  title: _TextsAndImages.title3,
                  subtitle: _TextsAndImages.subtitle3,
                  image: _TextsAndImages.image3,
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    3,
                    (index) => CircleAvatar(
                          radius: 4,
                          backgroundColor: index == myPage
                              ? Theme.of(context).hintColor
                              : Theme.of(context).backgroundColor,
                        )),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 8,
            margin: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: nextPage,
              child: const Text('Next'),
            ),
          )
        ],
      ),
    );
  }
}

class IntroImages extends StatelessWidget {
  const IntroImages({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
            Theme.of(context).backgroundColor.withOpacity(0.5),
            Theme.of(context).scaffoldBackgroundColor
          ])),
      height: MediaQuery.of(context).size.height / 2.4,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: Theme.of(context).brightness == Brightness.dark
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
              image: AssetImage(image),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter),
        ),
      ),
    );
  }
}

class IntroPageItems extends StatelessWidget {
  const IntroPageItems(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image})
      : super(key: key);
  final String title;
  final String subtitle;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntroImages(image: image),
        const Spacer(),
        Text(title, style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 20),
        Text(subtitle, textAlign: TextAlign.center, maxLines: 3),
        const Spacer(flex: 8)
      ],
    );
  }
}

class _TextsAndImages {
  static const String title1 = 'Chat and communicate';
  static const String subtitle1 =
      'Communicate with your friends and friends\nand find new ones based on common\ninterest';
  static const String image1 = AppImages.notification;

  static const String title2 = 'Smartphone or a laptop';
  static const String subtitle2 =
      'Stay up to date with all events, using any\ndevice conventient for you- we are\nmultiplatform';
  static const String image2 = AppImages.communication;

  static const String title3 = "Content that you'll";
  static const String subtitle3 =
      'Stay up to date with all events, using any\ndevice conventient for you- we are\nmultiplatform';
  static const String image3 = AppImages.hello;
}
