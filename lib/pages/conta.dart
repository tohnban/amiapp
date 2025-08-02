import 'package:ami_projecto/models/modelconta.dart';
import 'package:ami_projecto/models/video.dart';
import 'package:ami_projecto/pages/contalist.dart';
import 'package:ami_projecto/pages/enviardinheiro.dart';
import 'package:ami_projecto/pages/videogridview.dart';
import 'package:flutter/material.dart';

class Conta extends StatefulWidget {
  final ModelConta item;

  Conta({required this.item});

  @override
  State<Conta> createState() => _ContaState();
}

class _ContaState extends State<Conta> {
  List<Video> _myVideos = [
    Video(id: 'ZkIvWLIWXwo', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'yjNp-ZGU8DM', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'ZkIvWLIWXwo', isLive: false),
  ]; // Lista de vídeos locais
  //Seguidores
  List<ModelConta> seguidores = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minha Conta',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Foto do perfil centralizada
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      widget.item.ImagemUser, // Foto do perfil
                    ),
                    onBackgroundImageError: (_, __) {
                      // Tratamento para erro ao carregar a imagem
                      setState(() {
                        widget.item.ImagemUser =
                            'https://via.placeholder.com/100'; // Imagem padrão
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  // Nome do usuário
                  Text(
                    widget.item.NomeCompleto, // Nome do usuário
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 10),
                  // Número de seguidores e botão de seguir alinhados horizontalmente
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('1000 seguidores'),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(40, 35), // Largura e Altura
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16), // Bordas arredondadas
                          ),
                        ),
                        child: Text('Seguir'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Imagem que preenche a largura da tela
            Container(
              width: double.infinity,
              height: 130,
              child: Image.network(
                'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Tabs
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.blueGrey,
                    unselectedLabelColor: Colors.blueGrey[300],
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.video_collection,
                          color: Colors.green[400],
                        ),
                        text: 'Vídeos',
                      ),
                      Tab(
                        icon: Icon(
                          Icons.attach_money_sharp,
                          color: Colors.green[400],
                        ),
                        text: 'Ofertar',
                      ),
                      Tab(
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.green[400],
                        ),
                        text: 'A seguir',
                      ),
                    ],
                  ),
                  Container(
                    height: 300, // Altura dos conteúdos dos tabs
                    child: TabBarView(
                      children: [
                        // Tab "Meus Vídeos"
                        VideoGridView(videos: _myVideos),
                        // Tab "Ofertar"
                        EnviarDinheiroPage(item: widget.item.IdConta),
                        // Tab "A seguir"
                        ContaList(items: seguidores),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
