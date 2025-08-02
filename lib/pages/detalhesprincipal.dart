import 'package:ami_projecto/models/modelprincipal.dart';
import 'package:ami_projecto/models/modelsobre.dart';
import 'package:ami_projecto/pages/auxiliarlist.dart';
import 'package:ami_projecto/pages/enviardinheiro.dart';
import 'package:ami_projecto/pages/sobre.dart';
import 'package:flutter/material.dart';

class DetalhesPrincipal extends StatelessWidget {
  final ModelPrincipal item;

  DetalhesPrincipal({required this.item});

  final List<ModelPrincipal> relatedItems = [
    ModelPrincipal(
        imageUrl: 'https://via.placeholder.com/150',
        Titulo: 'Título Relacionado 1',
        Descricao: 'Descrição Relacionada 1',
        codigo: "101"),
    ModelPrincipal(
        imageUrl:
            'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
        Titulo: 'Título Relacionado 2',
        Descricao: 'Descrição Relacionada 2',
        codigo: "102"),
  ];
//Sobre Detalhes
  final ModelSobre modelSobre = ModelSobre(
    codigo: "",
    historia:
        "Nossa empresa foi fundada para atender às necessidades Nossa empresa foi fundada para atender às necessidades ...",
    fundadores: "João Silva e Maria Oliveira",
    dataFundacao: DateTime(2020, 5, 10),
    missao: "Proporcionar soluções inovadoras para facilitar a vida.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // Imagem de capa com o logo sobreposto
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: MediaQuery.of(context).size.height * 0.2 - 60,
                child: Image.network(
                  'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Título
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              item.Titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          // Subtítulo e botão de Avaliação
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Avaliação: 4.5',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ação ao pressionar o botão
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text('Avaliar'),
                        content: Text('Função Avaliar em Desenvolvimento!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Avaliar'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Abas
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Sobre'),
                      Tab(text: 'Ofertar'),
                      Tab(text: 'Auxiliar'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Aba "Sobre"
                        SobrePage(sobre: modelSobre),
                        // Aba "Oferta"
                        EnviarDinheiroPage(item: item.codigo),
                        // Aba "Auxiliar"
                        Auxiliarlist(items: relatedItems),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
