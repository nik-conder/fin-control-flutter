import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/presentation/ui/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionsListComponent extends StatefulWidget {
  const TransactionsListComponent({Key? key}) : super(key: key);

  @override
  State<TransactionsListComponent> createState() =>
      _TransactionsListComponentState();
}

class _TransactionsListComponentState extends State<TransactionsListComponent> {
  final ScrollController _scrollControllerList = ScrollController();
  final _pageSize = TransactionsLimits.pageSize;
  int countItemsList = 0;

  final PagingController<int, FinTransaction> _pagingController =
      PagingController(firstPageKey: 0);
  late TransactionsBloc _transactionsBloc;

  @override
  void initState() {
    super.initState();
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _coutListUpdate();
    // _transactionsBloc.transactionsStream.listen((event) {
    //   if (event.length < _pageSize) {
    //     _pagingController.appendLastPage(event);
    //   }
    // });
  }

  _coutListUpdate() {
    setState(() {
      if (_pagingController.itemList != null) {
        countItemsList = _pagingController.itemList!.length;
      }
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _transactionsBloc.fetchPage(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Loaded: $countItemsList'),
              ],
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      _pagingController.refresh();
                      _coutListUpdate();
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            )
          ],
        ),
        SizedBox(
            height: 400,
            child: (screenWidth < 750)
                ? PagedListView<int, FinTransaction>.separated(
                    pagingController: _pagingController,
                    separatorBuilder: (context, index) {
                      return const Padding(padding: EdgeInsets.only(top: 12));
                    },
                    scrollController: _scrollControllerList,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4),
                    builderDelegate: PagedChildBuilderDelegate<FinTransaction>(
                      itemBuilder: (context, item, index) =>
                          TransactionItem(transaction: item),
                    ),
                  )
                : PagedGridView(
                    pagingController: _pagingController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (screenWidth > 900) ? 3 : 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3),
                    builderDelegate: PagedChildBuilderDelegate<FinTransaction>(
                        itemBuilder: (context, item, index) => TransactionItem(
                              transaction: item,
                            ))))
      ],
    );
  }
}

/*
SizedBox(
          height: 400,
          child: PagedListView<int, FinTransaction>.separated(
            pagingController: _pagingController,
            separatorBuilder: (context, index) {
              return const Padding(padding: EdgeInsets.only(top: 12));
            },
            scrollController: _scrollControllerList,
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            builderDelegate: PagedChildBuilderDelegate<FinTransaction>(
              itemBuilder: (context, item, index) =>
                  TransactionItem(transaction: item),
            ),
          ),
        )
        */