import 'package:flutter/material.dart';
import 'package:armazenamento/models/gasto.dart';
import 'package:armazenamento/data/gastodatabase.dart';

class VisualizarGastosScreen extends StatelessWidget {
  const VisualizarGastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visualizar Gastos')),
      body: FutureBuilder<List<Gasto>>(
        future: GastoDatabase.getGastos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum gasto cadastrado.'));
          }

          final gastos = snapshot.data!;
          return ListView.builder(
            itemCount: gastos.length,
            itemBuilder: (context, index) {
              final gasto = gastos[index];
              return ListTile(
                title: Text('${gasto.simbolo} ${gasto.valor.toStringAsFixed(2)}'),
                subtitle: Text('${gasto.descricao} - ${gasto.moeda}'),
              );
            },
          );
        },
      ),
    );
  }
}
