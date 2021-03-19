import 'app.dart';
import 'model/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
      ChangeNotifierProvider(create: (_) => AppStateModel(), child: TollarApp()));
}
