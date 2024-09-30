import 'package:flutter/material.dart';

void main() {
  runApp(BankingApp());
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankingHomePage(),
    );
  }
}

class BankingHomePage extends StatefulWidget {
  @override
  _BankingHomePageState createState() => _BankingHomePageState();
}

class _BankingHomePageState extends State<BankingHomePage> {
  final List<String> _transactions = [];
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();


  void _addTransaction() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _transactions.add(_controller.text); 
      });
      _controller.clear(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação Bancária'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Nova transação',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma transação';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _addTransaction,
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: _transactions.isEmpty
                  ? Center(child: Text('Nenhuma transação registrada'))
                  : ListView.builder(
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(_transactions[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
