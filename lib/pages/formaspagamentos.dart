import 'package:flutter/material.dart';

class FormasPagamentoPage extends StatefulWidget {
  const FormasPagamentoPage({super.key});

  @override
  State<FormasPagamentoPage> createState() => _FormasPagamentoPageState();
}

class _FormasPagamentoPageState extends State<FormasPagamentoPage> {
  String? tipoSelecionado;
  final List<Map<String, String>> metodosDePagamento = [];

  // Controladores dos campos de entrada
  final TextEditingController formaPagamentoController =
      TextEditingController();
  final TextEditingController chaveOuTelefoneController =
      TextEditingController();
  final TextEditingController nomeBancoController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController numeroContaController = TextEditingController();
  final TextEditingController swiftController = TextEditingController();

  // Opções de formas de pagamento para Internet banking e Apps
  final List<String> opcoesFormaPagamento = [
    'PayPal',
    'Cartão de Crédito',
    'Chave de Transferência',
  ];

  void _adicionarMetodoDePagamento() {
    if (tipoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Selecione um tipo de pagamento antes de adicionar."),
        ),
      );
      return;
    }

    Map<String, String> metodo;

    if (tipoSelecionado == "Internet banking e Apps") {
      if (formaPagamentoController.text.isEmpty ||
          chaveOuTelefoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Preencha todos os campos para Internet banking."),
          ),
        );
        return;
      }

      metodo = {
        "Tipo": tipoSelecionado!,
        "Forma de Pagamento": formaPagamentoController.text,
        "Chave/Telefone": chaveOuTelefoneController.text,
      };
    } else if (tipoSelecionado == "Depósitos e Transferência") {
      if (nomeBancoController.text.isEmpty ||
          ibanController.text.isEmpty ||
          numeroContaController.text.isEmpty ||
          swiftController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Preencha todos os campos para Depósitos e Transferência."),
          ),
        );
        return;
      }

      metodo = {
        "Tipo": tipoSelecionado!,
        "Nome do Banco": nomeBancoController.text,
        "IBAN": ibanController.text,
        "Número da Conta": numeroContaController.text,
        "Swift": swiftController.text,
      };
    } else {
      return;
    }

    setState(() {
      metodosDePagamento.add(metodo);
      // Limpar os campos após adicionar
      formaPagamentoController.clear();
      chaveOuTelefoneController.clear();
      nomeBancoController.clear();
      ibanController.clear();
      numeroContaController.clear();
      swiftController.clear();
      tipoSelecionado = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Método de pagamento adicionado!")),
    );
  }

  // Função para editar o método
  void _editarMetodo(int index) {
    final metodo = metodosDePagamento[index];

    setState(() {
      tipoSelecionado = metodo["Tipo"];
      if (tipoSelecionado == "Internet banking e Apps") {
        formaPagamentoController.text = metodo["Forma de Pagamento"]!;
        chaveOuTelefoneController.text = metodo["Chave/Telefone"]!;
      } else if (tipoSelecionado == "Depósitos e Transferência") {
        nomeBancoController.text = metodo["Nome do Banco"]!;
        ibanController.text = metodo["IBAN"]!;
        numeroContaController.text = metodo["Número da Conta"]!;
        swiftController.text = metodo["Swift"]!;
      }

      // Remover o método antigo
      metodosDePagamento.removeAt(index);
    });
  }

  // Função para excluir o método
  void _excluirMetodo(int index) {
    setState(() {
      metodosDePagamento.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Método de pagamento excluído!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forma de Pagamento"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tipo de Pagamento
            const Text(
              "Selecione o Tipo de Pagamento:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: tipoSelecionado,
              hint: const Text("Escolha uma opção"),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: "Internet banking e Apps",
                  child: Text("Internet banking e Apps"),
                ),
                DropdownMenuItem(
                  value: "Depósitos e Transferência",
                  child: Text("Depósitos e Transferência"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  tipoSelecionado = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Campos dinâmicos
            if (tipoSelecionado == "Internet banking e Apps") ...[
              DropdownButton<String>(
                value: formaPagamentoController.text.isEmpty
                    ? null
                    : formaPagamentoController.text,
                hint: const Text("Escolha a forma de pagamento"),
                isExpanded: true,
                items: opcoesFormaPagamento.map((opcao) {
                  return DropdownMenuItem<String>(
                    value: opcao,
                    child: Text(opcao),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    formaPagamentoController.text = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: chaveOuTelefoneController,
                decoration: const InputDecoration(
                  labelText: "Chave ou Telefone",
                  border: OutlineInputBorder(),
                ),
              ),
            ] else if (tipoSelecionado == "Depósitos e Transferência") ...[
              TextField(
                controller: nomeBancoController,
                decoration: const InputDecoration(
                  labelText: "Nome do Banco",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ibanController,
                decoration: const InputDecoration(
                  labelText: "IBAN",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: numeroContaController,
                decoration: const InputDecoration(
                  labelText: "Número da Conta",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: swiftController,
                decoration: const InputDecoration(
                  labelText: "Swift",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 20),

            // Botão para adicionar o método de pagamento
            ElevatedButton(
              onPressed: _adicionarMetodoDePagamento,
              child: const Text("Adicionar Método de Pagamento"),
            ),
            const SizedBox(height: 20),

            // Lista de métodos de pagamento adicionados
            const Text(
              "Métodos de Pagamento Adicionados:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (metodosDePagamento.isEmpty)
              const Text("Nenhum método de pagamento adicionado ainda."),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: metodosDePagamento.length,
              itemBuilder: (context, index) {
                final metodo = metodosDePagamento[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...metodo.entries.map((entry) {
                          return Text(
                            "${entry.key}: ${entry.value}",
                            style: const TextStyle(fontSize: 14),
                          );
                        }).toList(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editarMetodo(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _excluirMetodo(index),
                            ),
                          ],
                        ),
                      ],
                    ),
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
