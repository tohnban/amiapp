import 'package:ami_projecto/models/modelprincipal.dart';
import 'package:ami_projecto/pages/detalhesprincipal.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<ModelPrincipal> items = [
    ModelPrincipal(
        imageUrl: 'https://via.placeholder.com/150',
        Titulo: 'Título 1 Título 1 Título 1 Título 1 Título 1 Título 1',
        Descricao: 'Subtítulo 1',
        codigo: "1"),
    ModelPrincipal(
        imageUrl:
            'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
        Titulo: 'Título 2',
        Descricao: 'Subtítulo 2',
        codigo: "2"),
    ModelPrincipal(
        imageUrl: 'https://via.placeholder.com/150',
        Titulo: 'Título 3',
        Descricao: 'Subtítulo 3',
        codigo: "3"),
    // Adicione mais itens conforme necessário
  ];

  List<ModelPrincipal> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool showSearchBox = false; // Controle de visibilidade da caixa de pesquisa

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void filterSearchResults(String query) {
    List<ModelPrincipal> dummyList = [];
    if (query.isNotEmpty) {
      dummyList.addAll(items.where(
          (item) => item.Titulo.toLowerCase().contains(query.toLowerCase())));
      setState(() {
        filteredItems = dummyList;
      });
    } else {
      setState(() {
        filteredItems = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Principal Page',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.green),
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
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  prefixIcon: Icon(
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
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      item.imageUrl,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child:
                              Icon(Icons.broken_image, color: Colors.grey[700]),
                        );
                      },
                    ),
                    title: Text(
                      item.Titulo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      item.Descricao,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesPrincipal(item: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
