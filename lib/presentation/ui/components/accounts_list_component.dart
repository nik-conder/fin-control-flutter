import 'package:fin_control/domain/bloc/account/account_state.dart';
import 'package:fin_control/domain/bloc/settings/settings_bloc.dart';
import 'package:fin_control/domain/bloc/token/token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/bloc/account/account_event.dart';

class AccountsListComponent extends StatefulWidget {
  const AccountsListComponent({Key? key}) : super(key: key);

  @override
  State<AccountsListComponent> createState() => _AccountsListComponentState();
}

class _AccountsListComponentState extends State<AccountsListComponent> {
  @override
  void initState() {
    //context.read<TokenBloc>().add(GetToken());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //         onPressed: () =>
          //             {context.read<AccountBloc>().add(FetchAccounts())},
          //         child: const Text('Обновить')),
          //   ],
          // ),
          // BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
          //   if (state is AccountLoading) {
          //     return const CircularProgressIndicator();
          //   } else if (state is AccountLoaded) {
          //     return SizedBox(
          //       height: 100,
          //       child: Column(
          //         children: [
          //           Expanded(
          //             child: ConstrainedBox(
          //               constraints: BoxConstraints(maxHeight: 300),
          //               child: ListView.builder(
          //                 padding: const EdgeInsets.all(4),
          //                 shrinkWrap: false,
          //                 scrollDirection: Axis.vertical,
          //                 itemCount: state.accounts.length,
          //                 itemBuilder: (BuildContext context, int index) {
          //                   final account = state.accounts[index];
          //                   return Container(
          //                     height: 50,
          //                     child: Column(
          //                       children: [
          //                         Text(
          //                             '${index + 1}. ${account.id}, ${account.type}'),
          //                         Text(account.openedDate.toString())
          //                       ],
          //                     ),
          //                   );
          //                 },
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   } else {
          //     return Text('No data');
          //   }
          // }),
        ],
      ),
    );
  }
}
