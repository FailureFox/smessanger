import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/styles/images.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  nextPage() {
    if (_pageController.page! < 3) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      print('123');
    }
  }

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            children: const [IntroFirstPage(), SizedBox()],
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
                        backgroundColor: index == (_pageController.page ?? 0)
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
            onPressed: () {},
            child: const Text('Next'),
          ),
        )
      ],
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

class IntroFirstPage extends StatelessWidget {
  const IntroFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IntroImages(image: AppImages.notification),
        const Spacer(),
        Text('Chat and communicate',
            style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 20),
        const Text(
            'Communicate with your friends and friends\nand find new ones based on common\ninterest',
            textAlign: TextAlign.center,
            maxLines: 3),
        const Spacer(flex: 8)
      ],
    );
  }
}

class IntroSecondPage extends StatelessWidget {
  const IntroSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
