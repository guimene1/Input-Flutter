import 'package:armazenamento/screens/gastos_screen.dart';
import 'package:flutter/material.dart';
import 'visualizargastos_screen.dart';

class TipomonetarioScreen extends StatefulWidget {
  const TipomonetarioScreen({super.key});

  @override
  State<TipomonetarioScreen> createState() => _TipomonetarioScreenState();
}

class _TipomonetarioScreenState extends State<TipomonetarioScreen> {
  var moeda = ['Real', 'Dólar', 'Euro', 'Libra'];
  var moedaSelecionada = 'Real';
  var simbolo = ['R\$', 'US\$', '€', '£'];
  var simboloSelecionado = 'R\$';
  var indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar Tipo Monetário')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Escolha sua moeda:'),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: moedaSelecionada,
              items: moeda.map((String moeda) {
                return DropdownMenuItem<String>(
                  value: moeda,
                  child: Text(moeda),
                );
              }).toList(),
              onChanged: (String? novaMoeda) {
                if (novaMoeda != null) {
                  setState(() {
                    moedaSelecionada = novaMoeda;
                    indice = moeda.indexOf(novaMoeda);
                    simboloSelecionado = simbolo[indice];
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Text('Símbolo: $simboloSelecionado'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisualizarGastosScreen(),
                  ),
                ).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              child: const Text('Visualizar Gastos'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GastosScreen(
                      moeda: moedaSelecionada,
                      simbolo: simboloSelecionado,
                    ),
                  ),
                );
              },
              child: const Text('Ir para tela de Gastos'),
            ),
          ],
        ),
      ),
    );
  }
}
