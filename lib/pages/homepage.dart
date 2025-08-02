import 'package:ami_projecto/pages/chatpage.dart';
import 'package:ami_projecto/pages/directopage.dart';
import 'package:ami_projecto/pages/navbar.dart';
import 'package:ami_projecto/pages/pesquisarvideo.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Homepage extends StatefulWidget {
  final List<String> videoIds;
  const Homepage({super.key, required this.videoIds});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController _pageController;
  bool _isVisible = true;
  String _selectedLanguage = 'PT';
  int _selectedIndex = 0;
  bool _isMenuSelected = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, Map<String, String>> _translations = {
    'EN': {
      'titulo': 'AMI',
      'todos': 'Video',
      'pesquisar': 'Search',
      'directo': 'Direct',
      'chat': 'Chat',
      'menu': 'Menu',
    },
    'PT': {
      'titulo': 'AMI',
      'todos': 'Videos',
      'pesquisar': 'Pesquisar',
      'directo': 'Directo',
      'chat': 'Chat',
      'menu': 'Menu',
    },
    'FR': {
      'titulo': 'AMI',
      'todos': 'Videos',
      'pesquisar': 'Rechercher',
      'directo': 'Direct',
      'chat': 'Chat',
      'menu': 'Menu',
    },
    'LG': {
      'titulo': 'AMI',
      'todos': 'Videos',
      'pesquisar': 'Koluka',
      'directo': 'Sikoyo',
      'chat': 'Kosolola',
      'menu': 'Menu',
    },
    'KG': {
      'titulo': 'AMI',
      'todos': 'Videos',
      'pesquisar': 'Vava',
      'directo': 'Wau',
      'chat': 'Moko',
      'menu': 'Menu',
    },
  };

  String getTranslation(String key) {
    return _translations[_selectedLanguage]?[key] ?? key;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      setState(() {
        _isMenuSelected = true;
      });
      _scaffoldKey.currentState?.openDrawer();
    } else if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DiretoScreen()),
      );
    } else if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Pesquisarvideo()),
      );
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ChatPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
        _isMenuSelected = false;
        if (index == 0) {
          _pageController.jumpToPage(0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              icon: const Icon(
                Icons.language,
                color: Colors.green, // Ícone de idioma verde
              ),
              value: _selectedLanguage,
              items: <String>['PT', 'LG', 'FR', 'KG', 'EN'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/$value.png',
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(value, style: TextStyle(color: Colors.blueGrey)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
            ),
            Center(
              child: Text(
                'Ami',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontFamily: 'CustomFont',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            IconButton(
              icon: Icon(
                _isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.green, // Ícone de visibilidade verde
              ),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
            ),
          ],
        ),
      ),
      drawer: const Navbar(),
      body: widget.videoIds.isEmpty
          ? Center(child: Text('Nenhum vídeo disponível.'))
          : PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: widget.videoIds.length,
              itemBuilder: (context, index) {
                final controller = YoutubePlayerController(
                  initialVideoId: widget.videoIds[index],
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                );

                bool isRestarting = false;

                controller.addListener(() {
                  if (controller.value.isReady) {
                    final position = controller.value.position;
                    final duration = controller.metadata.duration;

                    // Verifica se está próximo ao fim e se já não está reiniciando
                    if (duration.inSeconds > 0 &&
                        position.inSeconds >= duration.inSeconds - 1 &&
                        !isRestarting) {
                      isRestarting = true;

                      // Reinicia o vídeo sem delay para evitar repetição
                      controller.seekTo(Duration.zero);
                      controller.play();
                    }

                    // Redefine a flag quando o vídeo volta ao início
                    if (position == Duration.zero && isRestarting) {
                      isRestarting = false;
                    }
                  }
                });

                return YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.green, // Barra de progresso verde
                    handleColor: Colors.greenAccent, // Manipulador verde claro
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Permite mais de 3 itens
        selectedItemColor: Colors.blueGrey, // Cor dos rótulos selecionados
        unselectedItemColor:
            Colors.blueGrey, // Cor dos rótulos não selecionados
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.video_collection_sharp,
              color: Colors.green, // Ícone verde
            ),
            label: getTranslation('todos'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.videocam,
              color: Colors.green, // Ícone verde
            ),
            label: getTranslation('directo'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.screen_search_desktop_rounded,
              color: Colors.green, // Ícone verde
            ),
            label: getTranslation('pesquisar'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.video_chat_rounded,
              color: Colors.green, // Ícone verde
            ),
            label: getTranslation('chat'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.view_module,
              color: Colors.green, // Ícone verde
            ),
            label: getTranslation('menu'),
            backgroundColor:
                _isMenuSelected ? Colors.transparent : Colors.green,
          ),
        ],
        // Removido o `unselectedLabelStyle` para manter os rótulos na cor azul acinzentada
        showUnselectedLabels: true,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
    );
  }
}
