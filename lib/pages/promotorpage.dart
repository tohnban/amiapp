import 'package:ami_projecto/models/modelconta.dart';
import 'package:ami_projecto/pages/contalist.dart';
import 'package:flutter/material.dart';

class PromotorPage extends StatefulWidget {
  const PromotorPage({super.key});

  @override
  State<PromotorPage> createState() => _PromotorPageState();
}

class _PromotorPageState extends State<PromotorPage> {
  List<ModelConta> items = [
    ModelConta(
      IdConta: 'Utilizador1',
      NomeCompleto: 'Utilizador',
      ImagemUser: 'https://via.placeholder.com/150',
    ),
    ModelConta(
      IdConta: 'Utilizador2',
      NomeCompleto: 'Utilizador 2',
      ImagemUser:
          'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
    ),
    ModelConta(
      IdConta: 'Utilizador3',
      NomeCompleto: 'Utilizador 3',
      ImagemUser: 'https://via.placeholder.com/150',
    ),
  ];

  List<ModelConta> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool showSearchBox = false;

  @override
  void initState() {
    super.initState();
    filteredItems = items; // Inicialmente, mostrar todos os itens
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredItems = items
            .where((item) =>
                item.NomeCompleto.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredItems = items; // Voltar a mostrar todos os itens
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Promotor Page',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              showSearchBox ? Icons.close : Icons.search,
              color: Colors.green,
            ),
            onPressed: () {
              setState(() {
                showSearchBox = !showSearchBox;
                if (!showSearchBox) {
                  searchController.clear();
                  filterSearchResults('');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (showSearchBox)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterSearchResults,
                decoration: InputDecoration(
                  labelText: 'Pesquisar',
                  labelStyle: const TextStyle(color: Colors.blueGrey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ContaList(
              items: filteredItems, // Passar os itens filtrados para exibição
            ),
          ),
        ],
      ),
    );
  }
}
