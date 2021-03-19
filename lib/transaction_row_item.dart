import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'model/transaction.dart' as t;
import 'styles.dart';

class TransactionRowItem extends StatelessWidget {
  const TransactionRowItem({
    this.transaction,
    this.lastItem,
  });

  final t.Transaction transaction;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            // child: Image.asset(product.assetName, package: product.assetPackage, fit: BoxFit.cover, width: 76, height: 76),
            child: Text("asdf"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.description,
                    style: Styles.transactionRowItemName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    '\$${transaction.amount}',
                    style: Styles.transactionRowItemName,
                  )
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // final model = Provider.of<AppStateModel>(context, listen: false);
              // model.addProductToCart(product.id);
            },
            child: const Icon(
              CupertinoIcons.plus_circled,
              semanticLabel: 'Add',
            ),
          ),
        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.transactionRowDivider,
          ),
        ),
      ],
    );
  }
}
