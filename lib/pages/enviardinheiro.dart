import 'package:flutter/material.dart';

class EnviarDinheiroPage extends StatefulWidget {
  final String item;

  EnviarDinheiroPage({required this.item});

  @override
  _EnviarDinheiroPageState createState() => _EnviarDinheiroPageState();
}

class _EnviarDinheiroPageState extends State<EnviarDinheiroPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  String? validarMontante(String? value) {
    if (value == null || value.isEmpty) {
      return "O campo de montante é obrigatório.";
    }
    double? amount = double.tryParse(value);
    if (amount == null || amount < 10.0) {
      return "O valor deve ser igual ou maior que 10.00 AOA.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Fazer uma oferta",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Campo de Montante
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: "Montante (AOA)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: validarMontante,
              ),
              const SizedBox(height: 20),
              // Botão de Enviar
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Dinheiro enviado com sucesso!"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Ofertar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
