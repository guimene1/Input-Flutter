import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // precisa importar para usar TextInputFormatter
import 'package:armazenamento/models/gasto.dart';
import 'package:armazenamento/data/gastodatabase.dart';

class GastosScreen extends StatefulWidget {
  final String moeda;
  final String simbolo;

  const GastosScreen({super.key, required this.moeda, required this.simbolo});

  @override
  State<GastosScreen> createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  final valorController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gastos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Moeda: ${widget.moeda} (${widget.simbolo})'),
            TextField(
              controller: valorController,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (valorController.text.isEmpty ||
                    descricaoController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos!')),
                  );
                  return;
                }

                // tentativa de conversão segura
                final valor = double.tryParse(valorController.text);
                if (valor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Digite um valor numérico válido!')),
                  );
                  return;
                }

                final gasto = Gasto(
                  valor: valor,
                  descricao: descricaoController.text,
                  moeda: widget.moeda,
                  simbolo: widget.simbolo,
                );

                await GastoDatabase.insertGasto(gasto);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Gasto salvo!')));

                Navigator.pop(context, true);
              },
              child: const Text('Salvar Gasto'),
            ),
          ],
        ),
      ),
    );
  }
}
