import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_search_bloc/person_search_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_search_bloc/person_search_state.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';
import 'package:smessanger/injections.dart' as rep;
import 'package:smessanger/src/ui/pages/movie_pages/sub_pages/movie_search_page.dart';
import 'package:smessanger/src/ui/styles/images.dart';

class ChatSearchPage extends StatelessWidget {
  const ChatSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PersonSearchBloc(searchPerson: rep.sl.call<UserRepository>()),
      child: const ChatSearchBody(),
    );
  }
}

class ChatSearchBody extends StatefulWidget {
  const ChatSearchBody({Key? key}) : super(key: key);

  @override
  State<ChatSearchBody> createState() => _ChatSearchBodyState();
}

class _ChatSearchBodyState extends State<ChatSearchBody> {
  final ScrollController _controller = ScrollController();
  bool _isClosed = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isClosed = isClosed;
      setState(() {});
    });
  }

  bool get isClosed {
    return _controller.hasClients &&
        _controller.offset > (150 - kToolbarHeight);
  }

  String lastInputValue = '';
  Timer? _debounce;
  _onSearchChanged(VoidCallback function) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      function();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: AnimatedCrossFade(
                firstChild: Text(
                  'Search',
                  style: Theme.of(context).textTheme.headline2,
                ),
                secondChild: const SizedBox(),
                crossFadeState: _isClosed
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300)),
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text('Search',
                        style: Theme.of(context).textTheme.headline1),
                    SearchInput(
                      enabled: true,
                      onTap: () {},
                      onChanged: (text) {
                        if (text != lastInputValue && text != '') {
                          lastInputValue = text;
                          _onSearchChanged(
                            () {
                              BlocProvider.of<PersonSearchBloc>(context)
                                  .personSearchFromNumber(number: text);
                            },
                          );
                        }
                      },
                      text: 'Chats, channels and peoples...',
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<PersonSearchBloc, PersonSearchState>(
              builder: (context, state) {
            if (state is PersonSearchLoaded) {
              return SliverList(
                delegate: SliverChildListDelegate.fixed(
                  state.users
                      .map((e) => PersonSearchListItems(model: e))
                      .toList(),
                ),
              );
            } else if (state is PersonSearchEmpty) {
              return const FilmsSearchEmptyWidget(
                image: AppImages.empty,
                whiteColor: Colors.black45,
                darkColor: Colors.white54,
                text: 'No data',
              );
            } else if (state is PersonSearchInitialState) {
              return const FilmsSearchEmptyWidget(
                whiteColor: Colors.black45,
                darkColor: Colors.white54,
                image: AppImages.searching,
                text: 'Search',
              );
            } else {
              return FilmsSearchEmptyWidget(
                  whiteColor: Colors.black45,
                  darkColor: Colors.white54,
                  widget: Container(
                    width: MediaQuery.of(context).size.height / 20,
                    height: MediaQuery.of(context).size.height / 20,
                    margin: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ),
                  image: AppImages.loading,
                  text: 'Loading...');
            }
          })
        ],
      ),
    );
  }
}

class PersonSearchListItems extends StatelessWidget {
  const PersonSearchListItems({Key? key, required this.model})
      : super(key: key);
  final UserModel model;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(100),
        child: CircleAvatar(
          backgroundImage: NetworkImage(model.avatarUrl!),
          backgroundColor: Theme.of(context).backgroundColor,
          radius: MediaQuery.of(context).size.width / 14,
        ),
      ),
      title: Text(model.name),
      subtitle: Text(model.phoneNumber),
      onTap: () {},
    );
  }
}
