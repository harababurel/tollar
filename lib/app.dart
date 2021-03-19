import 'model/transaction.dart' as transaction;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'transactions_tab.dart';
import 'util/db.dart' as db_util;

class TollarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: TollarHomepage(),
    );
  }
}

class TollarHomepage extends StatefulWidget {
  final dbUtil = db_util.DatabaseUtil.instance;

  @override
  _TollarHomepageState createState() => _TollarHomepageState();
}

class _TollarHomepageState extends State<TollarHomepage> {
  final dbUtil = db_util.DatabaseUtil.instance;
  // final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    populateDb();
  }

  void populateDb() async {
    await dbUtil.insert(transaction.Transaction(
        id: 1, description: "food", amount: 19.9, currency: "CHF"));
    await dbUtil.insert(transaction.Transaction(
        id: 2, description: "drugs", amount: 1234, currency: "EUR"));
    await dbUtil.insert(transaction.Transaction(
        id: 3, description: "pepis", amount: 6000, currency: "RON"));

    final cnt = await dbUtil.getTransactionCount();
    debugPrint('Transaction count: ${cnt}');
    final transactions = await dbUtil.getAllTransactions();
    transactions.forEach((t) {
      debugPrint('found t: ${t.description}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          label: 'Main',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.money_dollar_circle),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.creditcard),
          label: 'Accounts',
        ),
      ]),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TransactionListTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TransactionListTab(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TransactionListTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }

  /*
  void _pushSaved() {
    // Navigator.of(this.context)
    //     .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    //   final tiles = _saved.map((WordPair pair) {
    //     return ListTile(title: Text(pair.join(' '), style: _biggerFont));
    //   });
    //   final divided =
    //       ListTile.divideTiles(context: context, tiles: tiles).toList();

    //   return Scaffold(
    //     appBar: AppBar(title: Text("Saved Suggestions")),
    //     body: ListView(children: divided),
    //   );
    // }));
  }

  Widget _buildTransactions() {
    return FutureBuilder(
        future: dbUtil.getAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('snapshot.data: ${snapshot.data}');
            final transactions = snapshot.data;

            return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: transactions.length,
                itemBuilder: (context, i) {
                  // return i.isOdd ? Divider() : _buildRow(transactions[i ~/ 2]);
                  return _buildRow(transactions[i]);
                });
          } else {
            debugPrint('showing loading spinner');
            return CupertinoActivityIndicator();
          }
        });
  }

  Widget _buildRow(transaction.Transaction t) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(t.description, style: _biggerFont));
  }*/
}
