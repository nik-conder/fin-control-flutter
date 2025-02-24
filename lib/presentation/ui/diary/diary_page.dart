import 'package:fin_control/domain/bloc/account/account_bloc.dart';
import 'package:fin_control/domain/bloc/account/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'diary_content.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Row(
                children: [
                  Text('Diary'),
                  Spacer(),
                  BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                    if (state is AccountLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is AccountLoaded) {
                      return Text(
                        state.accounts.first.id,
                        style: Theme.of(context).textTheme.labelSmall,
                      );
                    } else {
                      return Text('...');
                    }
                  })
                ],
              ),
              pinned: true,
              floating: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Открытые позиции')),
                  Tab(child: Text('Трейды')),
                  Tab(child: Text('Сделки')),
                  Tab(child: Text('Транзакции')),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Text('Открытые позиции'),
            Text('Трейды'),
            Text('Сделки'),
            Text('Транзакции')
          ],
        ),
      )),
    );
  }
}
