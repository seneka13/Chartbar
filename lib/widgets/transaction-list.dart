import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String) removeTx;

  TransactionList(this._transactions, this.removeTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) => Column(
                children: [
                  Text(
                    "There is no transaction",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                var e = _transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(child: Text('\$${e.amount}'))),
                    ),
                    title: Text(
                      e.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(e.date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            onPressed: () => removeTx(e.id),
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => removeTx(e.id),
                          ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
