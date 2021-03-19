import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'model/app_state_model.dart';
import 'transaction_row_item.dart';
import 'model/transaction.dart' as t;

class TransactionListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Consumer<AppStateModel>(
        builder: (context, child, model) {
          final transactions = [
            t.Transaction(
                id: 1, description: "food", amount: 19.9, currency: "CHF"),
            t.Transaction(
                id: 2, description: "drugs", amount: 1234, currency: "EUR"),
            t.Transaction(
                id: 3, description: "pepis", amount: 6000, currency: "RON")
          ];

          return CustomScrollView(
            semanticChildCount: transactions.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Transactions'),
              ),
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < transactions.length) {
                        return TransactionRowItem(
                          transaction: transactions[index],
                          lastItem: index == transactions.length - 1,
                        );
                      }
                      return null;
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
