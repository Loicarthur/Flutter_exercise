import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculatrice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculatrice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nombre1Controller = TextEditingController();
  final TextEditingController _nombre2Controller = TextEditingController();
  String _result = '';
  String? _selectedOperation;

  void _calculateResult() {
    final double? nombre1 = double.tryParse(_nombre1Controller.text);
    final double? nombre2 = double.tryParse(_nombre2Controller.text);

    if (nombre1 == null || nombre2 == null) {
      _showSnackBar('Veuillez entrer des nombres valides.');
      return;
    }

    if (_selectedOperation == null) {
      _showSnackBar('Veuillez sélectionner une opération.');
      return;
    }

    double resultValue;
    switch (_selectedOperation) {
      case 'Addition':
        resultValue = nombre1 + nombre2;
        break;
      case 'Soustraction':
        resultValue = nombre1 - nombre2;
        break;
      case 'Multiplication':
        resultValue = nombre1 * nombre2;
        break;
      case 'Division':
        if (nombre2 == 0) {
          _showSnackBar('Division par zéro impossible.');
          return;
        }
        resultValue = nombre1 / nombre2;
        break;
      default:
        return;
    }

    setState(() {
      _result = resultValue.toString();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _nombre1Controller.dispose();
    _nombre2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, 
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nombre1Controller,
              decoration: const InputDecoration(
                labelText: 'Nombre 1',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nombre2Controller,
              decoration: const InputDecoration(
                labelText: 'Nombre 2',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row( 
                  children: [
                    Radio<String>(
                      value: 'Addition',
                      groupValue: _selectedOperation,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOperation = value;
                        });
                      },
                    ),
                    const Text('Addition'),
                  ],
                ),
                Row( 
                  children: [
                    Radio<String>(
                      value: 'Soustraction',
                      groupValue: _selectedOperation,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOperation = value;
                        });
                      },
                    ),
                    const Text('Soustraction'),
                  ],
                ),
                 Row( 
                  children: [
                    Radio<String>(
                      value: 'Multiplication',
                      groupValue: _selectedOperation,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOperation = value;
                        });
                      },
                    ),
                    const Text('Multiplication'),
                  ],
                ),
                 Row( 
                  children: [
                    Radio<String>(
                      value: 'Division',
                      groupValue: _selectedOperation,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOperation = value;
                        });
                      },
                    ),
                    const Text('Division'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateResult,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
              ),
              child: const Text('Calculer'),
            ),
            const SizedBox(height: 24),
            Text(
              'Résultat : $_result',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black87), 
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
