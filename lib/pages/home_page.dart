import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _altura = TextEditingController();

  TextEditingController _peso = TextEditingController();

  String _infoText = 'Informe seus dados';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calcularImc() {
    double altura = double.parse(_altura.text) / 100;
    double peso = double.parse(_peso.text);

    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso: ${imc.toStringAsFixed(2)}';
      } else if (imc < 24.9) {
        _infoText =
            'Parabéns você esta com seu peso ideal: ${imc.toStringAsFixed(2)}';
      } else if (imc < 34.9) {
        _infoText = 'Levemente acima do peso: ${imc.toStringAsFixed(2)}';
      } else if (imc < 34.9) {
        _infoText = 'Obesidade Grau I: ${imc.toStringAsPrecision(3)}';
      } else if (imc < 39.9) {
        _infoText = 'Obesidade Grau II: ${imc.toStringAsPrecision(3)}';
      } else {
        _infoText = 'Obesidade Grau III: ${imc.toStringAsPrecision(3)}';
      }
    });
  }

  _refreshData() {
    _altura.clear();
    _peso.clear();

    _formKey.currentState.reset();

    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculadora de IMC',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _refreshData,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 150,
                  ),
                  TextFormField(
                    controller: _altura,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Informe a altura';

                      if (double.parse(value) <= 0) return 'Valor invalido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _peso,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Peso (cm)',
                      labelStyle: TextStyle(
                        // fontSize: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Informe o peso';

                      if (double.parse(value) <= 0) return 'Valor invalido';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) _calcularImc();
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
