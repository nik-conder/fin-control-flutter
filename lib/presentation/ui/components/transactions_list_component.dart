import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_state.dart';
import 'package:fin_control/presentation/ui/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionsListComponent extends StatefulWidget {
  const TransactionsListComponent({Key? key}) : super(key: key);

  @override
  State<TransactionsListComponent> createState() =>
      _TransactionsListComponentState();
}

class _TransactionsListComponentState extends State<TransactionsListComponent> {
  final ScrollController _scrollControllerList = ScrollController();
  final _pageSize = TransactionsLimits.pageSize;

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
    final localizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocConsumer<TransactionsBloc, TransactionsState>(
          bloc: _transactionsBloc,
          listener: (context, state) {
            if (state is TransactionDeleteErrorState) {
              _pagingController.refresh();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(localizations.error)));
            } else if (state is TransactionDeleteSuccessState) {
              _pagingController.refresh();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: Text(localizations.transaction_successfully_deleted),
              ));
            } else if (state is TransactionAddSuccessState) {
              _pagingController.refresh();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: Text(localizations.transaction_successfully_added),
              ));
            } else if (state is TransactionAddErrorState) {
              _pagingController.refresh();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(localizations.error)));
            }
          },
          builder: (context, state) => SizedBox(
            height: 400,
            child: (screenWidth < 750)
                ? PagedListView<int, FinTransaction>.separated(
                    pagingController: _pagingController,
                    separatorBuilder: (context, index) {
                      return const Padding(padding: EdgeInsets.only(top: 8));
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
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
