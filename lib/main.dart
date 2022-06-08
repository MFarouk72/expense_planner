import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

 /*
 // to disable rotation
 WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
        ),
        fontFamily: "Quicksand",
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.purple,
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '1',
    //   title: 'Football',
    //   amount: 20.9,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Basketball',
    //   amount: 10.5,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   title: 'Volleyball',
    //   amount: 5.8,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;
  List<Transaction> get recentTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTransaction(addTx: _addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape= mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text("Show Chart"),
                Switch(value: _showChart, onChanged: (value){
                  setState(() {
                    _showChart = value;
                  });
                })
              ],
            ),
            if(!isLandScape) Column(
              children: [
                SizedBox(
                    height: mediaQuery.size.height * 0.3,
                    child: Chart(recentTransaction: recentTransaction)),
                txtList(mediaQuery),
              ],
            ),
            if(isLandScape)
            _showChart? SizedBox(
                height: mediaQuery.size.height * 0.6,
                child: Chart(recentTransaction: recentTransaction))
            :
            txtList(mediaQuery),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }

  Widget txtList(var mediaQuery){
    return SizedBox(
      height: mediaQuery.size.height * 0.6,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
  }
}
