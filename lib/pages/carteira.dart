import 'package:ami_projecto/pages/formaspagamentos.dart';
import 'package:flutter/material.dart';

class CarteiraPage extends StatefulWidget {
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  double saldoDisponivel = 1500.00; // Valor fictício
  List<Map<String, dynamic>> formasDePagamento = [
    {
      "nome": "Cartão Visa",
      "detalhes": "**** **** **** 1234",
      "visivel": false
    },
    {"nome": "PayPal", "detalhes": "email@exemplo.com", "visivel": false},
  ];
  List<String> historicoOperacoes = [
    "Recebido: \$500.00 - 21/11/2024",
    "Enviado: \$200.00 - 20/11/2024",
    "Recebido: \$1000.00 - 19/11/2024",
  ];

  DateTime? dataSelecionada;

  void _alternarVisibilidadeDetalhes(int index) {
    setState(() {
      formasDePagamento[index]["visivel"] =
          !formasDePagamento[index]["visivel"];
    });
  }

  void _filtrarHistorico() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Filtrando operações para ${dataSelecionada?.toLocal().toString().split(' ')[0] ?? "todas as datas"}"),
      ),
    );
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (data != null && data != dataSelecionada) {
      setState(() {
        dataSelecionada = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saldo disponível
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Saldo Disponível",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\$${saldoDisponivel.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 40,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Formas de pagamento
            Text(
              "Formas de Pagamento",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formasDePagamento.length,
              itemBuilder: (context, index) {
                final forma = formasDePagamento[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.credit_card, color: Colors.blue),
                        title: Text(forma["nome"]),
                        trailing: IconButton(
                          icon: Icon(
                            forma["visivel"]
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                          onPressed: () => _alternarVisibilidadeDetalhes(index),
                        ),
                      ),
                      if (forma["visivel"])
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Detalhes: ${forma["detalhes"]}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            // Botão Adicionar nova forma de pagamento
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormasPagamentoPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Adicionar nova forma de pagamento"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Histórico de Operações
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Histórico de Operações",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Imprimindo relatório...")),
                    );
                  },
                  child: const Text(
                    "Imprimir",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: dataSelecionada == null
                          ? "Selecione uma data"
                          : dataSelecionada!.toLocal().toString().split(' ')[0],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selecionarData(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _filtrarHistorico,
                  child: const Text("Filtrar"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: historicoOperacoes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.history, color: Colors.grey),
                    title: Text(historicoOperacoes[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
