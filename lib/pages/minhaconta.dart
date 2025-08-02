import 'package:ami_projecto/models/video.dart';
import 'package:ami_projecto/pages/carteira.dart';
import 'package:ami_projecto/pages/diretolist.dart';
import 'package:flutter/material.dart';

class Minhaconta extends StatefulWidget {
  @override
  _MinhacontaState createState() => _MinhacontaState();
}

class _MinhacontaState extends State<Minhaconta> {
  List<Video> _myVideos = [
    Video(id: 'ZkIvWLIWXwo', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'yjNp-ZGU8DM', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'ZkIvWLIWXwo', isLive: false),
  ]; // Lista de vídeos locais

  List<Video> _favoriteVideos = [
    Video(id: 'ZkIvWLIWXwo', isLive: false),
    Video(id: 'yjNp-ZGU8DM', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'ZkIvWLIWXwo', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'yjNp-ZGU8DM', isLive: false),
  ]; // Lista de vídeos favoritos

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
                      'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Nome do usuário
                  Text(
                    'Nome do Usuário',
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
                            // fontSize: 16, // Tamanho da fonte
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
                        text: 'Meus Vídeos',
                      ),
                      Tab(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.green[400],
                        ),
                        text: 'Favoritos',
                      ),
                      Tab(
                        icon: Icon(
                          Icons.wallet,
                          color: Colors.green[400],
                        ),
                        text: 'Carteira',
                      ),
                    ],
                  ),
                  Container(
                    height: 300, // Altura dos conteúdos dos tabs
                    child: TabBarView(
                      children: [
                        // Tab "Meus Vídeos"
                        DiretoList(videos: _myVideos),
                        // Tab "Favoritos"
                        DiretoList(videos: _favoriteVideos),
                        //Tab "Carteira"
                        CarteiraPage(),
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
