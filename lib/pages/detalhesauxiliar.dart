import 'package:ami_projecto/models/modelatividade.dart';
import 'package:ami_projecto/models/modelconta.dart';
import 'package:ami_projecto/models/modelprincipal.dart';
import 'package:ami_projecto/models/video.dart';
import 'package:ami_projecto/pages/atividadespage.dart';
import 'package:ami_projecto/pages/contalist.dart';
import 'package:ami_projecto/pages/enviardinheiro.dart';
import 'package:ami_projecto/pages/videogridview.dart';
import 'package:flutter/material.dart';

class DetalhesAuxiliar extends StatefulWidget {
  final ModelPrincipal item;

  const DetalhesAuxiliar({required this.item, Key? key}) : super(key: key);

  @override
  _DetalhesAuxiliarState createState() => _DetalhesAuxiliarState();
}

class _DetalhesAuxiliarState extends State<DetalhesAuxiliar> {
  late String Codigoconta;
  late List<Video> _myVideos;
  // Inicializa a lista com os dados fixos
  List<ModelConta> utilizadores = [
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
// Carregar as actividades do auxiliar
  final List<Atividade> actividades = [
    Atividade(
      imagemUrl:
          'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
      titulo: "Caminhada Ecológica",
      descricao:
          "Participe de uma caminhada pela natureza para promover a consciência ambiental.",
      data: DateTime.now(),
    ),
    Atividade(
      imagemUrl:
          'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
      titulo: "A victoria",
      descricao:
          "Viva uma caminhada pela natureza para promover a consciência ambiental.",
      data: DateTime.now(),
    ),
    Atividade(
      imagemUrl:
          'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
      titulo: "O amor verdadeiro",
      descricao:
          "Incentive uma caminhada pela natureza para promover a consciência ambiental.",
      data: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    Codigoconta = "xzdzgkzk";
    _myVideos = [
      Video(id: 'ZkIvWLIWXwo', isLive: false),
      Video(id: '2izp7IJVugs', isLive: false),
      Video(id: 'yjNp-ZGU8DM', isLive: false),
      Video(id: '2izp7IJVugs', isLive: false),
      Video(id: 'ZkIvWLIWXwo', isLive: false),
    ];
  }

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
          // Imagem de capa
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16), // Espaçamento

          // Título
          const Text(
            'Página Auxiliar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Subtítulo e botão "Seguir"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Seguidores: 1.2K',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Ação ao pressionar o botão
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
                child: const Text('Seguir'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Abas 'Sobre', 'Utilizadores', 'Atividades' e 'Vídeos'
          DefaultTabController(
            length: 4,
            child: Expanded(
              child: Column(
                children: [
                  const TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Vídeos'),
                      Tab(text: 'Ofertar'),
                      Tab(text: 'Actividades'),
                      Tab(text: 'Promotor'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Conteúdo rolável da aba 'Vídeos'
                        VideoGridView(videos: _myVideos),
                        // Conteúdo rolável da aba 'Oferta'
                        EnviarDinheiroPage(item: Codigoconta),
                        // Conteúdo rolável da aba 'Atividades'
                        AtividadePage(atividades: actividades),

                        // Conteúdo rolável da aba 'Utilizadores'
                        ContaList(items: utilizadores),
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
